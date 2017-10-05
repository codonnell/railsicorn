class GroupAttackChecker
  def initialize(response, attack)
    @attack = attack
    @response = response
  end

  def is_group_attack?
    contains_attack?(@response, @attack)
  end

  private

  # def events_request
  #   api_key = @attack.attacker.user.api_key
  #   ApiRequest.new(path: :user, selections: [:events], api_key: api_key)
  # end

  # def events_caller
  #   ApiCaller.new(events_request, RateLimiter.new(@attack.attacker.user))
  # end

  def contains_attack?(response, attack)
    response[:events].each do |_, event|
      if event_matches?(event, attack)
        return true
      end
    end
    false
  end

  def event_matches?(event, attack)
    timestamp_matches?(event, attack) && string_matches?(event, attack)
  end

  def timestamp_matches?(event, attack)
    event[:timestamp] == attack.timestamp_ended.strftime('%s').to_i
  end

  def string_matches?(event, attack)
    regex = /.*XID=(\d+).*and.*attacked.*XID=(\d+).*/
    match_data = regex.match(event[:event])
    match_data[1].to_i == attack.attacker.torn_id &&
      match_data[2].to_i == attack.defender.torn_id
  end
end
