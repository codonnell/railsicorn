require 'test_helper'

class UpdateFactionAttacksJobTest < ActiveJob::TestCase
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

  test 'updates an active faction\'s attacks' do
    request = ApiRequest.faction_attacks('api_key')
    stub_request(:get, request.url)
      .to_return(body: JSON.dump(generic_attacks))
    faction = create(:faction, api_key: 'api_key', torn_id: 13)
    player = create(:player, torn_id: 12, faction: faction)
    assert(player.attacks.empty?)
    UpdateFactionAttacksJob.perform_now
    assert_not(player.attacks.empty?)
    assert_requested(:get, request.url)
  end
end
