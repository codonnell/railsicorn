class Attack < ApplicationRecord
  belongs_to :attacker, class_name: 'Player', optional: true
  belongs_to :defender, class_name: 'Player'

  WINS = Set.new(%w(Hospitalize Leave Mug)).freeze

  def win?
    WINS.member? result
  end

  def loss?
    !win?
  end
end
