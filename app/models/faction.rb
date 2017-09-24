class Faction < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :players, dependent: :nullify

  def authorized?
    torn_id == 16628 || torn_id == 8981 || torn_id == 8989
  end
end
