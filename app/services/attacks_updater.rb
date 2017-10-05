require 'parallel'

class AttacksUpdater
  def initialize(api_caller)
    @api_caller = api_caller
  end

  def call
    response = @api_caller.call
    validator = AttacksValidator.new(response)
    raise validator.errors.to_s if validator.invalid?
    attacks = coerce(response)
    attack_ids = attacks.map { |attack| attack[:torn_id] }
    new_ids = Set.new(attack_ids) - Set.new(known_ids(attack_ids))
    new_attacks = attacks.map { |attack| new(attack) if new_ids.include?(attack[:torn_id]) }.compact
    update_battle_stats(new_attacks)
    update_difficulties(new_attacks)
    save(new_attacks)
    new_attacks
  end

  private

  def known_ids(attack_ids)
    Attack.where(torn_id: attack_ids).pluck(:torn_id)
  end

  def coerce(response)
    AttacksCoercer.new(response).call
  end

  def exists?(attack)
    Attack.find_by(torn_id: attack[:torn_id])
  end

  def new(attack)
    resolve_attacker_reference(attack)
    resolve_defender_reference(attack)
    Attack.new(attack)
  end

  def resolve_attacker_reference(attack)
    return if attack[:attacker_id].nil?
    attack[:attacker] = Player.find_or_create_by(torn_id: attack[:attacker_id])
    attack.delete :attacker_id
  end

  def resolve_defender_reference(attack)
    attack[:defender] = Player.find_or_create_by(torn_id: attack[:defender_id])
    attack.delete :defender_id
  end

  def update_battle_stats(new_attacks)
    pairs = new_attacks.map { |attack| [attack.attacker, attack.defender] }
    players_to_update = Set.new(pairs.flatten.compact).select(&:active_user?)
    Rails.application.executor.wrap do
      Parallel.each(players_to_update,
        in_threads: Rails.application.config.request_threads) do |player|
        ActiveRecord::Base.connection_pool.with_connection do
          request = ApiRequest.battle_stats(player.user.api_key)
          api_caller = ApiCaller.new(request, RateLimiter.new(player.user))
          BattleStatsUpdater.new(api_caller, player).call
        end
      end
    end
  end

  def update_difficulties(attacks)
    maybe_group_attacks = attacks.select { |attack| attack.attacker && attack.attacker.active_user? }
    Rails.application.executor.wrap do
      Parallel.each(maybe_group_attacks,
        in_threads: Rails.application.config.request_threads) do |attack|
        ActiveRecord::Base.connection_pool.with_connection do
          user = attack.attacker.user
          request = ApiRequest.player_events(user.api_key)
          api_caller = ApiCaller.new(request, RateLimiter.new(user))
          events = api_caller.call
          if GroupAttackChecker.new(events, attack).is_group_attack?
            attack.group_attack = true
          else
            update_difficulty(attack)
          end
        end
      end
    end
  end

  def update_difficulty(attack)
    return if attack.attacker.nil? || attack.attacker.total_battle_stats.nil?
    attacker = attack.attacker
    defender = attack.defender
    if attack.loss? && new_strongest_defense(attacker, defender)
      defender.update(most_stats_defended_against: attacker.total_battle_stats)
    elsif attack.win? && new_weakest_attacker(attacker, defender)
      defender.update(least_stats_beaten_by: attacker.total_battle_stats)
    end
  end

  def new_strongest_defense(attacker, defender)
    defender[:most_stats_defended_against].nil? ||
      defender[:most_stats_defended_against] < attacker.total_battle_stats
  end

  def new_weakest_attacker(attacker, defender)
    defender[:least_stats_beaten_by].nil? ||
      defender[:least_stats_beaten_by] > attacker.total_battle_stats
  end

  def save(attacks)
    attacks.each do |attack|
      add_timestamp(attack)
      attack.save
    end
  end

  def add_timestamp(attack)
    attack[:timestamp] = DateTime.now
  end
end
