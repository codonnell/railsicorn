require 'test_helper'

class IncRequestsAvailableJobTest < ActiveJob::TestCase
  test 'requests_available is incremented when less than 10' do
    user = create(:user, requests_available: 5)
    assert_equal(5, user.requests_available)
    IncRequestsAvailableJob.perform_now
    assert_equal(10, user.reload.requests_available)
  end

  test 'requests_available is not incremented when equal to 10' do
    user = create(:user, requests_available: 10)
    assert_equal(10, user.requests_available)
    IncRequestsAvailableJob.perform_now
    assert_equal(10, user.reload.requests_available)
  end
end
