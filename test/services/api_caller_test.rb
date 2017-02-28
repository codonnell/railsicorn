require 'test_helper'

class ApiCallerTest < ActiveSupport::TestCase
  def valid_body
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
  end

  def empty_key_resp
    { error: { code: 1, error: 'Key is empty' } }
  end

  def invalid_key_resp
    { error: { code: 2, error: 'Incorrect Key' } }
  end


  test 'calls specified url' do
    request = ApiRequest.battle_stats('api_key')
    api_caller = ApiCaller.new(request, NoRateLimiter.new)
    stub_request(:get, request.url).to_return(body: JSON.dump(valid_body))
    api_caller.call
    assert_requested(:get, request.url)
  end

  test 'invalidates api keys on empty key response' do
    user = create(:user, api_key: 'api_key')
    faction = create(:faction, api_key: 'api_key')
    request = ApiRequest.battle_stats('api_key')
    api_caller = ApiCaller.new(request, NoRateLimiter.new)
    stub_request(:get, request.url).to_return(body: JSON.dump(empty_key_resp))
    assert_raises(EmptyKeyError) { api_caller.call }
    assert_nil(user.reload.api_key)
    assert_nil(faction.reload.api_key)
  end
end
