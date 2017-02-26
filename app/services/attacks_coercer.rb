class AttacksCoercer
  def initialize(response)
    @response = convert_to_array(response.clone)
  end

  def call
    @response.each do |attack|
      convert_timestamps(attack)
      remove_player_names(attack)
      remove_faction_info(attack)
      make_anon_attacker_nil(attack)
    end
    @response
  end

  private

  def convert_to_array(response)
    attacks = []
    response[:attacks].each do |torn_id, attack|
      attack[:torn_id] = torn_id.to_s.to_i
      attacks << attack
    end
    attacks
  end

  def convert_timestamps(attack)
    attack[:timestamp_started] = convert_timestamp(attack[:timestamp_started])
    attack[:timestamp_ended] = convert_timestamp(attack[:timestamp_ended])
  end

  def remove_player_names(attack)
    attack.delete :attacker_name
    attack.delete :defender_name
  end

  def remove_faction_info(attack)
    attack.delete :attacker_faction
    attack.delete :attacker_factionname
    attack.delete :defender_faction
    attack.delete :defender_factionname
  end

  def make_anon_attacker_nil(attack)
    attack[:attacker_id] = nil if attack[:attacker_id] == ''
  end

  def convert_timestamp(secs)
    DateTime.parse(Time.at(secs).to_s)
  end
end
