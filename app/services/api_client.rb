require 'rest-client'
require 'json'

class ApiClient

  # user can be any model with an api key and a requests_available attribute
  def initialize(user)
    @user = user
    @api_key = user.api_key
  end

  attr_reader :api_key

  # Inspired by Ruby Cookbook
  # (https://www.safaribooksonline.com/library/view/ruby-cookbook/0596523696/ch03s12.html)
  # Perhaps this should take an optional timeout or number of retries?
  def await_request
    retry_after_seconds = 1
    loop do
      before = Time.now
      @user.with_lock do
        if request_available?
          @user.decrement! :requests_available
          return
        end
      end
      interval = retry_after_seconds - (Time.now - before)
      sleep(interval) if interval > 0
    end
  end

  def request_available?
    @user.reload.requests_available > 0
  end

end
