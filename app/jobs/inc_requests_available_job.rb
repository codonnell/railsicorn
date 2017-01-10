class IncRequestsAvailableJob < ActiveJob::Base
  def perform
    User.update_all(requests_available: 10)
  end
end
