class UserRegistrar
  def initialize(api_key)
    @api_key = api_key
  end

  def call
    user = User.find_by(api_key: @api_key)
    return user if user
    player_info = request_player_info
    player = player_info.player
    user = update_user(player)
    update_battle_stats(user)
  rescue EmptyKeyError, IncorrectKeyError
    return nil
  end

  private

  def request_player_info
    api_caller = ApiCaller.new(ApiRequest.player_info(@api_key), NoRateLimiter.new)
    PlayerInfoUpdater.new(api_caller).call
  end

  def update_battle_stats(user)
    api_caller = ApiCaller.new(ApiRequest.battle_stats(@api_key),
      RateLimiter.new(user))
    BattleStatsUpdater.new(api_caller, user.player).call
  end

  def update_user(player)
    if player.user
      player.user.update(api_key: @api_key, faction: player.faction)
      player.user
    else
      User.create(api_key: @api_key, faction: player.faction, player: player)
    end
  end
end
