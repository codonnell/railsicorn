require 'rest-client'
require 'json'

class ApiCaller
  attr_reader :request

  def initialize(request, rate_limiter)
    @request = request
    @rate_limiter = rate_limiter
  end

  # Note that this can block if a user is at their rate limit
  def call(options: {})
    request_available = @rate_limiter.await_request(10)
    raise RateLimitError unless request_available
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
  rescue EmptyKeyError, IncorrectKeyError => e
    invalidate_api_key(@request.api_key)
    raise e
  end

  def invalidate_api_key(api_key)
    Faction.where(api_key: api_key).each { |faction| faction.update(api_key: nil) }
    User.where(api_key: api_key).each { |user| user.update(api_key: nil) }
  end
end
