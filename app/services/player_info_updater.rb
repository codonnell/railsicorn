class PlayerInfoUpdater
  def initialize(api_caller)
    @api_caller = api_caller
  end

  def call
    response = @api_caller.call
    validator = PlayerInfoValidator.new(response)
    raise validator.errors.to_s if validator.invalid?
    @response = coerce(response)
    resolve_references
    add_timestamp
    puts @response
    PlayerInfoUpdate.create(@response)
  rescue InvalidIdError
    destroy_invalid_player
  end

  private

  def destroy_invalid_player
    id = @api_caller.request.id
    Player.find_by(torn_id: id).destroy!
    Rails.logger.info "Destroyed invalid player with torn id #{id}"
  end

  def coerce(response)
    PlayerInfoCoercer.new(response).call
  end

  def resolve_references
    find_or_create_player
    update_player_faction
    find_or_create_spouse
  end

  def find_or_create_player
    player = Player.find_by(torn_id: @response[:player])
    player.update(signup: @response[:signup]) unless player.nil? || player.signup
    unless player
      player = Player.create(torn_id: @response[:player], signup: @response[:signup])
    end
    remove_new_player_attributes
    @response[:player] = player
  end

  def remove_new_player_attributes
    @response.delete :signup
  end

  def find_or_create_spouse
    if @response[:spouse].zero?
      @response[:spouse] = nil
    else
      @response[:spouse] = Player.find_or_create_by(torn_id: @response[:spouse])
    end
  end

  def update_player_faction
    faction = @response[:faction].zero? ? nil :
      Faction.find_or_create_by(torn_id: @response[:faction])
    player = @response[:player]
    player.update(faction: faction)
    player.user.update(faction: faction) if player.user
    @response.delete :faction
  end

  def add_timestamp
    @response[:timestamp] = DateTime.now
  end
end
