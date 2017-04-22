require 'test_helper'

class RelevantPlayerInfoTest < ActiveSupport::TestCase
  test 'returns existing player info' do
    player = create(:player, least_stats_beaten_by: 5000.0)
    create(:player_info_update, player: player, xanax_taken: 100)
    info = player.relevant_player_info
    assert_equal(100, info.xanax_taken)
    assert_equal(5000.0, info.least_stats_beaten_by)
  end

  test 'returns nil stats without player info' do
    player = create(:player)
    info = player.relevant_player_info
    assert_not_nil(info)
    assert_nil(info.xanax_taken)
  end

  test 'returns the most recent player info' do
    player = create(:player)
    create(:player_info_update, player: player, timestamp: 1.month.ago, xanax_taken: 50)
    create(:player_info_update, player: player, timestamp: 2.weeks.ago, xanax_taken: 100)
    assert_equal(100, player.relevant_player_info.xanax_taken)
  end
end
