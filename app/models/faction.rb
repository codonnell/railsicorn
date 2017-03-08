class Faction < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :players, dependent: :nullify

  def authorized?
    torn_id == 16628
  end
end
