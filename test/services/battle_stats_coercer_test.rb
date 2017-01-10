require 'test_helper'

class BattleStatsCoercerTest < ActiveSupport::TestCase
  def orig_response
    { strength: 1.0,
      dexterity: 1.0,
      speed: 1.0,
      defense: 1.0,
      strength_modifier: 2,
      dexterity_modifier: -2,
      speed_modifier: 0,
      defense_modifier: 35,
      strength_info: ['Stuff from education'] }
  end

  def coerced_response
    { strength: 1.0,
      dexterity: 1.0,
      speed: 1.0,
      defense: 1.0,
      strength_modifier: 1.02,
      dexterity_modifier: 0.98,
      speed_modifier: 1.0,
      defense_modifier: 1.35 }
  end

  test 'coerces modifiers' do
    assert_equal(
      coerced_response,
      BattleStatsCoercer.new(orig_response).coerce
    )
  end
end
