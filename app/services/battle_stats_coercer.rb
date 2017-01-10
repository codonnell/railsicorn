class BattleStatsCoercer
  def initialize(response)
    @response = response
  end

  def coerce
    @response.map { |k, v| coerce_pair(k, v) }.to_h.slice(*valid_keys)
  end

  private

  def valid_keys
    [
      :strength, :dexterity, :speed, :defense, :strength_modifier,
      :dexterity_modifier, :speed_modifier, :defense_modifier
    ]
  end

  def coerce_pair(k, v)
    [k, modifier_keys.member?(k) ? coerce_modifier(v) : v]
  end

  def coerce_modifier(value)
    (value + 100) / 100.0
  end

  def modifier_keys
    Set.new [
      :strength_modifier, :dexterity_modifier, :speed_modifier,
      :defense_modifier
    ]
  end
end
