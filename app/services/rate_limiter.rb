class RateLimiter

  def initialize(user)
    @user = user
    @api_key = user.api_key
  end

  def request_available?
    @user.reload.requests_available > 0
  end

  # Inspired by Ruby Cookbook
  # (https://www.safaribooksonline.com/library/view/ruby-cookbook/0596523696/ch03s12.html)
  # Perhaps this should take an optional timeout or number of retries?
  def await_request(timeout_seconds)
    attempts = 0
    retry_after_seconds = 1
    loop do
      before = Time.now
      return true if claim_request
      attempts += 1
      return false if attempts > timeout_seconds
      interval = retry_after_seconds - (Time.now - before)
      sleep(interval) if interval > 0
    end
  end

  private

  def claim_request
    @user.with_lock do
      if request_available?
        @user.decrement! :requests_available
        return true
      end
    end
    false
  end
end
