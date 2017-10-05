class ApiRequest
  def initialize(path:, selections:, id: '', api_key:, timestamp: nil)
    @path = path
    @selections = selections
    @id = id
    @api_key = api_key
    @timestamp = to_torn_timestamp(timestamp)
  end

  attr_reader :api_key
  attr_reader :id

  def url
    root_url +
      "/#{@path}/#{@id}?selections=#{to_attributes(@selections)}&key=#{@api_key}" +
      "#{@timestamp ? '&timestamp=' + @timestamp : ''}"
  end

  def self.faction_attacks(api_key, timestamp = nil)
    new(path: :faction, selections: [:attacks], api_key: api_key, timestamp: timestamp)
  end

  def self.player_attacks(api_key, timestamp = nil)
    new(path: :user, selections: [:attacks], api_key: api_key, timestamp: timestamp)
  end

  def self.player_info(api_key, torn_id = nil)
    new(path: :user, selections: [:profile, :personalstats], id: torn_id,
      api_key: api_key)
  end

  def self.battle_stats(api_key)
    new(path: :user, selections: [:battlestats], api_key: api_key)
  end

  def self.player_events(api_key, timestamp = nil)
    new(path: :user, selections: [:events], api_key: api_key, timestamp: timestamp)
  end

  private

  def root_url
    'https://api.torn.com'.freeze
  end

  def to_attributes(selection)
    selection.map(&:to_s).join(',')
  end

  def to_torn_timestamp(timestamp)
    timestamp.strftime('%s').to_i if timestamp
  end

end
