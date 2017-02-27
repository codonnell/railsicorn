require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test 'battle_stats returns the latest' do
    player = create(:player)
    create(:battle_stats_update, player: player, timestamp: 5.minutes.ago)
    update2 = create(:battle_stats_update, player: player, timestamp: 1.minute.ago)
    assert_equal(update2, player.battle_stats)
  end

  test 'battle_stats returns nil when none known' do
    player = create(:player)
    assert_nil(player.battle_stats)
  end

  test 'total battle stats are correct' do
    player = create(:player)
    create(:battle_stats_update, player: player, strength: 10.0,
      strength_modifier: 0.5, dexterity: 20.0, dexterity_modifier: 0.75,
      speed: 5.0, speed_modifier: 1.0, defense: 10.0, defense_modifier: 1.5)
    assert_in_delta(40.0, player.total_battle_stats)
  end

  test 'total battle stats is nil when unknown' do
    player = create(:player)
    assert_nil(player.total_battle_stats)
  end
end
