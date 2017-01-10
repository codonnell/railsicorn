require 'test_helper'

class BattleStatsUpdaterTest < ActiveSupport::TestCase
  valid_body =
    {
      strength: 1.0,
      dexterity: 2.0,
      speed: 3.0,
      defense: 4.0,
      strength_modifier: 10,
      dexterity_modifier: 5,
      speed_modifier: 0,
      defense_modifier: -5,
      strength_info: ['+ 2% Strength from education'],
      dexterity_info: ['+ 2% Dexterity from education'],
      speed_info: ['+ 2% Speed from education'],
      defense_info: ['+ 2% Defense from education']
    }

  test 'creates update with correct api response' do
    stub_request(:get, /.*api\.torn\.com.*/)
      .to_return(body: JSON.dump(valid_body))
    updater = BattleStatsUpdater.new(users(:one))
    update = updater.call
    assert_equal(1.0, update.strength)
    assert_equal(1.1, update.strength_modifier)
    assert_nil(update[:strength_info])
    assert BattleStatsUpdate.find_by(timestamp: update.timestamp)
  end

  test 'throw exception when request fails' do
    stub_request(:get, /.*api\.torn\.com.*/).to_timeout
    updater = BattleStatsUpdater.new(users(:one))
    assert_raises(Exception) { updater.call }
  end

  test 'throw exception on api error response' do
    body = JSON.dump(error: { code: 2, error: 'Incorrect Key' })
    stub_request(:get, /.*api\.torn\.com.*/).to_return(body: body)
    updater = BattleStatsUpdater.new(users(:one))
    assert_raises(Exception) { updater.call }
  end

  test 'throw exception on invalid response body' do
    invalid_body = valid_body.clone
    invalid_body[:strength] = 'foo'
    stub_request(:get, /.*api\.torn\.com.*/)
      .to_return(body: JSON.dump(invalid_body))
    updater = BattleStatsUpdater.new(users(:one))
    assert_raises(Exception) { updater.call }
  end
end
