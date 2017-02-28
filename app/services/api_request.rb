class ApiRequest
  def initialize(path:, selections:, id: '', api_key:)
    @path = path
    @selections = selections
    @id = id
    @api_key = api_key
  end

  attr_reader :api_key

  def url
    root_url +
      "/#{@path}/#{@id}?selections=#{to_attributes(@selections)}&key=#{@api_key}"
  end

  def self.player_attacks(api_key)
    new(path: :user, selections: [:attacks], api_key: api_key)
  end

  def self.player_info(api_key, torn_id = nil)
    new(path: :user, selections: [:profile, :personalstats], id: torn_id,
      api_key: api_key)
  end

  def self.battle_stats(api_key)
    new(path: :user, selections: [:battlestats], api_key: api_key)
  end

  private

  def root_url
    'https://api.torn.com'.freeze
  end

  def to_attributes(selection)
    selection.map(&:to_s).join(',')
  end

end
