class UserRegistrar
  def initialize(api_key)
    @api_key = api_key
  end

  def call
    user = User.find_by(api_key: @api_key)
    return user if user
    player_info = request_player_info
    player = player_info.player
    User.create(api_key: @api_key, faction: player.faction, player: player)
  rescue EmptyKeyError, IncorrectKeyError
    return nil
  end

  private

  def request_player_info
    api_caller = ApiCaller.new(ApiRequest.player_info(@api_key), NoRateLimiter.new)
    PlayerInfoUpdater.new(api_caller).call
  end
end
