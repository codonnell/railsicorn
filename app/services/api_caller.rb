require 'rest-client'
require 'json'

class ApiCaller
  def initialize(user, is_rate_limited: true)
    @client = ApiClient.new(user)
    @is_rate_limited = is_rate_limited
  end

  def user_info(torn_id)
    call(path: :user, selections: [:profile, :personalstats], id: torn_id)
  end

  def battle_stats
    call(path: :user, selections: [:battlestats])
  end

  def user_attacks
    call(path: :user, selections: [:attacks])
  end

  # Note that this can block if a user is at their rate limit
  def call(path:, selections:, id: '', options: {})
    @client.await_request if @is_rate_limited
    resp = RestClient.get query_path(path, selections, id), options
    JSON.parse(resp).deep_symbolize_keys
  end

  private

  def root_url
    'https://api.torn.com'.freeze
  end

  def query_path(path, selections, id)
    root_url +
      "/#{path}/#{id}?selections=#{to_attributes(selections)}&key=#{@client.api_key}"
  end

  def to_attributes(selection)
    selection.map(&:to_s).join(',')
  end
end
