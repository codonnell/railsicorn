class NoRateLimiter

  def request_available?
    true
  end

  # Inspired by Ruby Cookbook
  # (https://www.safaribooksonline.com/library/view/ruby-cookbook/0596523696/ch03s12.html)
  # Perhaps this should take an optional timeout or number of retries?
  def await_request(_)
    true
  end
end
