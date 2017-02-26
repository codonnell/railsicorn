class User < ApplicationRecord
  belongs_to :faction
  has_one :player
  after_initialize :init

  def init
    self.requests_available ||= 10
  end
end
