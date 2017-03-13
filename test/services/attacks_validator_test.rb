require 'test_helper'

class AttacksValidatorTest < ActiveSupport::TestCase
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

  test 'valid attacks are valid' do
    validator = AttacksValidator.new(generic_attacks)
    assert validator.valid?
  end

  test 'accepts integer names' do
    attacks = generic_attacks.clone
    attacks[:attacks][:"1"][:attacker_name] = 1234
    attacks[:attacks][:"1"][:attacker_factionname] = 0
    attacks[:attacks][:"1"][:defender_factionname] = 0
    validator = AttacksValidator.new(attacks)
    assert validator.valid?
  end

  test 'timestamps are not negative' do
    attacks = generic_attacks.clone
    attacks[:attacks][:"1"][:timestamp_started] = -1234
    validator = AttacksValidator.new(attacks)
    assert validator.invalid?
  end

  test 'result must be in accepted set' do
    attacks = generic_attacks.clone
    attacks[:attacks][:"1"][:result] = 'TKO'
    validator = AttacksValidator.new(attacks)
    assert validator.invalid?
  end
end
