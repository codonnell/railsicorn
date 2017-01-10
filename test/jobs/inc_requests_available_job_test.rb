require 'test_helper'

class IncRequestsAvailableJobTest < ActiveJob::TestCase
  test 'requests_available is incremented when less than 10' do
    assert_equal(5, users(:two).requests_available)
    IncRequestsAvailableJob.perform_now
    assert_equal(10, users(:two).reload.requests_available)
  end

  test 'requests_available is not incremented when equal to 10' do
    assert_equal(10, users(:one).requests_available)
    IncRequestsAvailableJob.perform_now
    assert_equal(10, users(:one).reload.requests_available)
  end
end
