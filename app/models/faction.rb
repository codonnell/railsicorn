class Faction < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :players, dependent: :nullify
end
