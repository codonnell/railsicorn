class BattleStatsUpdater
  def initialize(user)
    @user = user
  end

  def call
    response = request_update
    validator = BattleStatsValidator.new(response)
    raise validator.errors.to_s if validator.invalid?
    coerced = coerce(response)
    add_id(coerced)
    add_timestamp(coerced)
    BattleStatsUpdate.create(coerced)
  end

  # private

  def request_update
    caller = ApiCaller.new(@user)
    begin
      response = caller.battle_stats
    rescue StandardError
      raise 'Error connecting to server'
    end
    raise "API Error: #{response[:error]}" if response.key?(:error)
    response
  end

  def coerce(response)
    BattleStatsCoercer.new(response).coerce
  end

  def add_id(response)
    response[:player] = @user.player
  end

  def add_timestamp(response)
    response[:timestamp] = DateTime.now
  end
end
