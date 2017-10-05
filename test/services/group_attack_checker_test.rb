require 'test_helper'

class GroupAttackCheckerTest < ActiveSupport::TestCase
  def group_attack_events
    { events:
      {
      :"1" =>
        {
        timestamp: 1051,
        event: "<a href=http://www.torn.com/profiles.php?XID=1946152>sullengenie</a> and <a href=http://www.torn.com/profiles.php?XID=2011902>CrimsonXray</a> attacked and hospitalized <a href=http://www.torn.com/profiles.php?XID=705054>Shinigy</a> [<a href = \"http://www.torn.com/loader.php?sid=attackLog&ID=9ba882e47de969353217594fbf95c926\">view</a>]",
        seen: 0
        } } }
  end

  # Convert number of seconds since the epoch to a DateTime object
  def to_datetime(secs)
    DateTime.parse(Time.at(secs).to_s)
  end

  def matching_attack
    attacker = build(:player, torn_id: 1_946_152)
    defender = build(:player, torn_id: 705_054)
    build(:attack, attacker: attacker, defender: defender, timestamp_ended: to_datetime(1051))
  end

  def different_attacker_attack
    attacker = build(:player, torn_id: 1)
    defender = build(:player, torn_id: 705_054)
    build(:attack, attacker: attacker, defender: defender, timestamp_ended: to_datetime(1051))
  end

  def different_defender_attack
    attacker = build(:player, torn_id: 1_946_152)
    defender = build(:player, torn_id: 2)
    build(:attack, attacker: attacker, defender: defender, timestamp_ended: to_datetime(1051))
  end

  def different_timestamp_attack
    attacker = build(:player, torn_id: 1_946_152)
    defender = build(:player, torn_id: 705_054)
    build(:attack, attacker: attacker, defender: defender, timestamp_ended: to_datetime(2000))
  end

  test 'recognizes matching group attack' do
    checker = GroupAttackChecker.new(group_attack_events, matching_attack)
    assert checker.is_group_attack?
  end

  test 'does not recognize unmatching attacks' do
    assert_not GroupAttackChecker.new(group_attack_events, different_attacker_attack)
      .is_group_attack?
    assert_not GroupAttackChecker.new(group_attack_events, different_defender_attack)
      .is_group_attack?
    assert_not GroupAttackChecker.new(group_attack_events, different_timestamp_attack)
      .is_group_attack?
  end
end
