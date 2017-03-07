require 'test_helper'

class UpdateStalePlayersJobTest < ActiveJob::TestCase
  def min_resp
    {
      rank: "Absolute beginner ",
      level: 1,
      gender: "Male",
      property: "Shack",
      signup:  "2005-07-19 03:00:34",
      awards: 0,
      friends: 0,
      enemies: 0,
      forum_posts: nil,
      karma: 0,
      age: 100,
      role: "Civilian",
      donator: 0,
      player_id: 1,
      name: "Player1",
      property_id: 0,
      last_action: "100 days ago",
      life: {
        current: 100,
        maximum: 100,
        increment: 5,
        interval: 300,
        ticktime: 15,
        fulltime: 0
      },
      status: ["Okay", ""],
      job: {
        position: "None",
        company_id: 0
      },
      faction: {
        position: "None",
        faction_id: 0,
        days_in_faction: 17230,
        faction_name: "None"
      },
      married: {
        spouse_id: 0,
        spouse_name: "None",
        duration: 0
      },
      icons: { icon6: "Male" },
      personalstats: { refills: nil }
    }
  end

  test 'update never-updated players' do
    request = ApiRequest.player_info('api_key', 1)
    stub_request(:get, request.url)
      .to_return(body: JSON.dump(min_resp))
    player1 = create(:player, torn_id: 1)
    create(:user, api_key: 'api_key', player: player1)
    assert player1.player_info_updates.empty?
    UpdateStalePlayersJob.perform_now
    assert_not player1.player_info_updates.empty?
  end

  test 'update number of api keys amount of players' do
    stub_request(:get, /.*1\?/)
      .to_return(body: JSON.dump(min_resp))
    player2_resp = min_resp
    player2_resp[:player_id] = 2
    stub_request(:get, /.*2\?/)
      .to_return(body: JSON.dump(player2_resp))
    player1 = create(:player, torn_id: 1)
    create(:user, api_key: 'key1', player: player1)
    player2 = create(:player, torn_id: 2)
    create(:user, api_key: 'key2', player: player2)
    player3 = create(:player, torn_id: 3)
    create(:player_info_update, player: player2, spouse: nil, timestamp: 1.month.ago)
    create(:player_info_update, player: player3, spouse: nil, timestamp: 3.weeks.ago)
    assert_equal 1, player2.player_info_updates.size
    assert_equal 1, player3.player_info_updates.size
    assert player1.player_info_updates.empty?
    UpdateStalePlayersJob.perform_now
    assert_equal 1, player1.player_info_updates.size
    assert_equal 2, player2.player_info_updates.size
    assert_equal 1, player3.player_info_updates.size
  end

  test 'do not update players with a recent update' do
    request = ApiRequest.player_info('api_key', 1)
    stub_request(:get, request.url)
      .to_return(body: JSON.dump(min_resp))
    player1 = create(:player, torn_id: 1)
    create(:user, api_key: 'api_key', player: player1)
    create(:player_info_update, player: player1, spouse: nil, timestamp: 1.week.ago)
    assert_equal 1, player1.player_info_updates.size
    UpdateStalePlayersJob.perform_now
    assert_equal 1, player1.player_info_updates.size
  end
end
