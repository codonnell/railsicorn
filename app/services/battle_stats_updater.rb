class BattleStatsUpdater
  def initialize(api_caller, player)
    @api_caller = api_caller
    @player = player
  end

  def call
    response = @api_caller.call
    validator = BattleStatsValidator.new(response)
    raise validator.errors.to_s if validator.invalid?
    @response = coerce(response)
    add_id
    add_timestamp
    BattleStatsUpdate.create(@response)
  end

  private

  def coerce(response)
    BattleStatsCoercer.new(response).call
  end

  def add_id
    @response[:player] = @player
  end

  def add_timestamp
    @response[:timestamp] = DateTime.now
  end
end
