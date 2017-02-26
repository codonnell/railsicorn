class Attack < ApplicationRecord
  belongs_to :attacker, class_name: 'Player', optional: true
  belongs_to :defender, class_name: 'Player'
end
