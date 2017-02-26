require 'rest-client'
require 'json'

class ApiCaller
  def initialize(request, rate_limiter)
    @request = request
    @rate_limiter = rate_limiter
  end

  # Note that this can block if a user is at their rate limit
  def call(options: {})
    request_available = @rate_limiter.await_request(10)
    raise 'Rate limit exceeded' unless request_available
    raw_response = execute_request(@request, options: options)
    parsed_response = parse(raw_response)
    raise_if_api_error(parsed_response)
    parsed_response
  end

  private

  def execute_request(request, options: {})
    RestClient.get request.url, options
  end

  def parse(response)
    JSON.parse(response).deep_symbolize_keys
  end

  def raise_if_api_error(response)
    raise ApiError.from_hash(response) if response.key?(:error)
  end
end
