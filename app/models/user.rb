class User < ApplicationRecord
  belongs_to :faction
  has_one :player
end
