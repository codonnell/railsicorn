require 'test_helper'

class AttacksCoercerTest < ActiveSupport::TestCase
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

  def coerced_attacks
    [
      {
        torn_id: 1,
        timestamp_started: timestamp(1000),
        timestamp_ended: timestamp(1050),
        attacker_id: 12,
        defender_id: 14,
        result: 'Mug',
        respect_gain: 0
      },
      {
        torn_id: 2,
        timestamp_started: timestamp(1001),
        timestamp_ended: timestamp(1051),
        attacker_id: nil,
        defender_id: 14,
        result: 'Hospitalize',
        respect_gain: 5.32
      }
    ]
  end

  def timestamp(secs)
    DateTime.parse(Time.at(secs).to_s)
  end

  test 'coerces valid attacks properly' do
    coerced = AttacksCoercer.new(generic_attacks).call
    assert_equal(Set.new(coerced_attacks), Set.new(coerced))
    assert_instance_of(Array, coerced)
    assert_equal(coerced_attacks.size, coerced.size)
  end
end
