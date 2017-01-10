class Faction < ApplicationRecord
  has_many :users
  has_many :players
end
