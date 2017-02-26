class AttacksUpdater
  # should pass in ApiCaller here and that should be constructed with the endpoint it will hit. ApiCaller will then receive a call message and that's it.
  def initialize(api_caller)
    @api_caller = api_caller
  end

  def call
    response = @api_caller.call
    validator = AttacksValidator.new(response)
    raise validator.errors.to_s if validator.invalid?
    @attacks = coerce(response)
    @attacks.each { |attack| create(attack) unless exists?(attack) }
  end

  private

  def coerce(response)
    AttacksCoercer.new(response).call
  end

  def exists?(attack)
    Attack.find_by(torn_id: attack[:torn_id])
  end

  def create(attack)
    resolve_attacker_reference(attack)
    resolve_defender_reference(attack)
    Attack.create(attack)
  end

  def resolve_attacker_reference(attack)
    return if attack[:attacker_id].nil?
    attack[:attacker] = Player.find_or_create_by(torn_id: attack[:attacker_id])
    attack.delete :attacker_id
  end

  def resolve_defender_reference(attack)
    attack[:defender] = Player.find_or_create_by(torn_id: attack[:defender_id])
    attack.delete :defender_id
  end
end
