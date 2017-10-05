require 'test_helper'

class AttacksUpdaterTest < ActiveSupport::TestCase
  def empty_events
    { events: {}}
  end
  def group_attack_events
    { events:
      { :"1" =>
        {
          timestamp: 1050,
          seen: 0,
          event: '<a href="player.php?XID=12>twiddles</a> and (42 others) attacked <a href="player.php?XID=14">twoodled</a> and mugged her.'
        } } }
  end
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
      strength: 10.0,
      dexterity: 10.0,
      speed: 10.0,
      defense: 10.0,
      strength_modifier: 0,
      dexterity_modifier: 0,
      speed_modifier: 0,
      defense_modifier: 0,
      strength_info: [],
      dexterity_info: [],
      speed_info: [],
      defense_info: []
    }
  end

  def stub_attack_requests
    request = ApiRequest.player_attacks('api_key')
    stub_request(:get, request.url)
      .to_return(body: JSON.dump(generic_attacks))
    request
  end

  def stub_battle_stats_requests
    battle_stats_request = ApiRequest.battle_stats('api_key')
    stub_request(:get, battle_stats_request.url)
      .to_return(body: JSON.dump(battle_stats_body))
    battle_stats_request
  end

  def stub_events_requests
    events_request = ApiRequest.player_events('api_key')
    stub_request(:get, events_request.url)
      .to_return(body: JSON.dump(empty_events))
    events_request
  end

  test 'creates valid attacks and their associated players' do
    stub_attack_requests
    stub_events_requests
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
    attack_request = stub_attack_requests
    stub_events_requests
    api_caller = ApiCaller.new(attack_request, NoRateLimiter.new)
    updater = AttacksUpdater.new(api_caller)
    create(:attack, torn_id: 1, attacker_id: nil)
    assert(Attack.find_by(torn_id: 1).attacker.nil?)
    updater.call
    assert(Attack.find_by(torn_id: 1).attacker.nil?)
  end

  test 'updates battle stats for active users' do
    player = create(:player, torn_id: 12)
    create(:user, player: player, api_key: 'api_key')
    attack_request = stub_attack_requests
    stub_battle_stats_requests
    stub_events_requests
    api_caller = ApiCaller.new(attack_request, NoRateLimiter.new)
    AttacksUpdater.new(api_caller).call
    assert_not(player.battle_stats_updates.empty?)
    assert(player.battle_stats_updates.first.timestamp <=
      Attack.find_by(torn_id: 1).timestamp)
  end

  test 'does not update difficulties for group attacks' do
    events_request = ApiRequest.player_events('api_key')
    stub_request(:get, events_request.url)
    .to_return(body: JSON.dump(group_attack_events))
    player1 = create(:player, torn_id: 12)
    create(:user, player: player1, api_key: 'api_key')
    attack_request = stub_attack_requests
    stub_battle_stats_requests
    api_caller = ApiCaller.new(attack_request, NoRateLimiter.new)
    AttacksUpdater.new(api_caller).call
    assert_nil Player.find_by(torn_id: 14)[:least_stats_beaten_by]
  end

  # Should probably test all of the branches of this, but UGH
  # There has to be a better way, maybe programmatically generating attack and
  # battle stat stubs
  test 'updates difficulty measures' do
    stub_events_requests
    player1 = create(:player, torn_id: 12)
    create(:user, player: player1, api_key: 'api_key')
    attack_request = stub_attack_requests
    stub_battle_stats_requests
    api_caller = ApiCaller.new(attack_request, NoRateLimiter.new)
    AttacksUpdater.new(api_caller).call
    assert_equal(player1.total_battle_stats,
      Player.find_by(torn_id: 14)[:least_stats_beaten_by])
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
