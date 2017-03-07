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

  test 'stale player returns no info players first' do
    player1 = create(:player)
    create(:player_info_update, player: player1, spouse: nil, timestamp: 10.minutes.ago)
    player2 = create(:player)
    create(:player_info_update, player: player2, spouse: nil, timestamp: 5.minutes.ago)
    player3 = create(:player)
    assert_equal(Player.most_stale_players(1, Time.now), [player3])
    assert_equal(Set.new(Player.most_stale_players(2, Time.now)),
      Set.new([player1, player3]))
    assert_equal(Set.new(Player.most_stale_players(3, 6.minutes.ago)),
      Set.new([player1, player3]))
  end

  test 'computes player difficulty accurately' do
    weak_player = create(:player, least_stats_beaten_by: 20.0,
      most_stats_defended_against: 25.0)
    medium_player = create(:player, least_stats_beaten_by: 50.0,
      most_stats_defended_against: 70.0)
    strong_player = create(:player, least_stats_beaten_by: 50.0,
      most_stats_defended_against: 100.0)
    unknown_player = create(:player, least_stats_beaten_by: nil,
      most_stats_defended_against: nil)
    create(:battle_stats_update, player: weak_player, strength: 5.0,
      dexterity: 5.0, speed: 5.0, defense: 5.0)
    create(:battle_stats_update, player: strong_player, strength: 15.0,
      dexterity: 15.0, speed: 15.0, defense: 15.0)
    assert_equal(:easy, strong_player.difficulty(weak_player))
    assert_equal(:impossible, weak_player.difficulty(strong_player))
    assert_equal(:medium, strong_player.difficulty(medium_player))
    assert_equal(:unknown, strong_player.difficulty(unknown_player))
  end
end
