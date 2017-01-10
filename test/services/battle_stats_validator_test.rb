require 'test_helper'

class BattleStatsValidatorTest < ActiveSupport::TestCase
  def valid_response
    { strength: 1.0,
      dexterity: 1.0,
      speed: 1.0,
      defense: 1.0,
      strength_modifier: 2,
      dexterity_modifier: -2,
      speed_modifier: 0,
      defense_modifier: 35 }
  end

  test 'valid response returns valid' do
    validator = BattleStatsValidator.new(valid_response)
    assert validator.valid?
  end

  test 'missing key returns invalid' do
    missing = valid_response
    missing.delete(:strength)
    validator = BattleStatsValidator.new(missing)
    assert validator.invalid?
  end

  test 'wrong type returns invalid' do
    wrong_type = valid_response
    wrong_type[:strength] = 'foo'
    validator = BattleStatsValidator.new(wrong_type)
    assert validator.invalid?
  end

  test 'stats cannot be negative' do
    negative = valid_response
    negative[:strength] = -1.0
    validator = BattleStatsValidator.new(negative)
    assert validator.invalid?
  end
end
