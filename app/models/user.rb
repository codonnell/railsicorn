class User < ApplicationRecord
  belongs_to :faction
  has_one :player, dependent: :nullify
  after_initialize :init

  def init
    self.requests_available ||= 10
  end

  def self.active_users
    User.where.not(api_key: nil)
  end
end
