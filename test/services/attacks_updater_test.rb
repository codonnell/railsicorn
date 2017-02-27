require 'test_helper'

class AttacksUpdaterTest < ActiveSupport::TestCase
  def generic_attacks
    { attacks:
      { :"1" =>
        {
        timestamp_started: 1000,
        timestamp_ended: 1050,
        attacker_id: 12,
        attacker_name: 'twiddles',
        attacker_faction: 13,
        attacker_factionname: 'twiddlers',
        defender_id: 14,
        defender_name: 'twoodled',
        defender_faction: 15,
        defender_factionname: 'twoodleds',
        result: 'Mug',
        respect_gain: 0
        },
      :"2" =>
        {
        timestamp_started: 1001,
        timestamp_ended: 1051,
        attacker_id: "",
        attacker_name: nil,
        attacker_faction: "",
        attacker_factionname: nil,
        defender_id: 14,
        defender_name: 'twoodled',
        defender_faction: 15,
        defender_factionname: 'twoodleds',
        result: 'Hospitalize',
        respect_gain: 5.32
        } } }
  end

  def battle_stats_body
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

  test 'creates valid attacks and their associated players' do
    stub_request(:get, /.*api\.torn\.com.*/)
      .to_return(body: JSON.dump(generic_attacks))
    api_caller = ApiCaller.new(ApiRequest.player_attacks('api_key'),
      NoRateLimiter.new)
    updater = AttacksUpdater.new(api_caller)
    assert_not(Attack.find_by(torn_id: 1))
    assert_not(Attack.find_by(torn_id: 2))
    assert_not(Player.find_by(torn_id: 12))
    updater.call
    attack1 = Attack.find_by(torn_id: 1)
    attack2 = Attack.find_by(torn_id: 2)
    assert(attack1)
    assert(attack1.timestamp)
    assert(attack2)
    assert(Player.find_by(torn_id: 12))
  end

  test 'does not update existing attacks' do
    stub_request(:get, /.*api\.torn\.com.*/)
      .to_return(body: JSON.dump(generic_attacks))
    api_caller = ApiCaller.new(ApiRequest.player_attacks('api_key'),
      NoRateLimiter.new)
    updater = AttacksUpdater.new(api_caller)
    create(:attack, torn_id: 1, attacker_id: nil)
    assert(Attack.find_by(torn_id: 1).attacker.nil?)
    updater.call
    assert(Attack.find_by(torn_id: 1).attacker.nil?)
  end

  test 'updates battle stats for active users' do
    player = create(:player, torn_id: 12)
    create(:user, player: player, api_key: 'api_key')
    request = ApiRequest.player_attacks('api_key')
    stub_request(:get, request.url)
      .to_return(body: JSON.dump(generic_attacks))
    battle_stats_request = ApiRequest.battle_stats('api_key')
    stub_request(:get, battle_stats_request.url)
      .to_return(body: JSON.dump(battle_stats_body))
    api_caller = ApiCaller.new(request, NoRateLimiter.new)
    AttacksUpdater.new(api_caller).call
    assert_not(player.battle_stats_updates.empty?)
    assert(player.battle_stats_updates.first.timestamp <=
      Attack.find_by(torn_id: 1).timestamp)
  end

  test 'raise exception when request fails' do
    stub_request(:get, /.*api\.torn\.com.*/).to_timeout
    api_caller = ApiCaller.new(ApiRequest.player_attacks('api_key'),
      NoRateLimiter.new)
    updater = AttacksUpdater.new(api_caller)
    assert_raises(Exception) { updater.call }
  end

  test 'raise exception on api error response' do
    body = JSON.dump(error: { code: 2, error: 'Incorrect Key' })
    stub_request(:get, /.*api\.torn\.com.*/).to_return(body: body)
    api_caller = ApiCaller.new(ApiRequest.player_attacks('api_key'),
      NoRateLimiter.new)
    updater = AttacksUpdater.new(api_caller)
    assert_raises(Exception) { updater.call }
  end

  test 'raise exception on invalid response body' do
    invalid_body = {}
    stub_request(:get, /.*api\.torn\.com.*/)
      .to_return(body: JSON.dump(invalid_body))
    api_caller = ApiCaller.new(ApiRequest.player_attacks('api_key'),
      NoRateLimiter.new)
    updater = AttacksUpdater.new(api_caller)
    assert_raises(Exception) { updater.call }
  end
end
