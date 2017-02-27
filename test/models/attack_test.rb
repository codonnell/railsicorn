require 'test_helper'

class AttackTest < ActiveSupport::TestCase
  test 'win? returns correctly' do
    assert build(:attack, result: 'Hospitalize').win?
    assert build(:attack, result: 'Leave').win?
    assert build(:attack, result: 'Mug').win?
    assert_not build(:attack, result: 'Run away').win?
    assert_not build(:attack, result: 'Stalemate').win?
    assert_not build(:attack, result: 'Timeout').win?
    assert_not build(:attack, result: 'Lose').win?
  end

  test 'loss? returns correctly' do
    assert_not build(:attack, result: 'Hospitalize').loss?
    assert_not build(:attack, result: 'Leave').loss?
    assert_not build(:attack, result: 'Mug').loss?
    assert build(:attack, result: 'Run away').loss?
    assert build(:attack, result: 'Stalemate').loss?
    assert build(:attack, result: 'Timeout').loss?
    assert build(:attack, result: 'Lose').loss?
  end
end
