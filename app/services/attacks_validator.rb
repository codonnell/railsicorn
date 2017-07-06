require 'dry-validation'

class AttacksValidator < Validator
  def initialize(response)
    attacks_array = convert_to_array(response)
    @result = schema.call(attacks_array)
  end

  Schema = Dry::Validation.Schema do
    each do
      schema do
        required(:torn_id) { int? & gt?(0) }
        required(:timestamp_started) { int? & gt?(0) }
        required(:timestamp_ended) { int? & gt?(0) }
        required(:attacker_id) { str? > empty? | int? & gt?(0) }
        required(:attacker_name) { none? | str? | int? | float? }
        required(:attacker_faction) { str? > empty? | int? & gt?(0) }
        required(:attacker_factionname) { none? | str? | int? }
        required(:defender_id) { int? & gt?(0) }
        required(:defender_name) { str? | int? | float? }
        required(:defender_faction) { str? > empty? | int? & gt?(0) }
        required(:defender_factionname) { none? | str? | int? }
        required(:respect_gain) { int? > eql?(0) | float? & gteq?(0.0) }
        required(:result).value(included_in?:
          ['Hospitalize', 'Stalemate', 'Leave', 'Mug', 'Lose', 'Run away',
           'Timeout'])
      end
    end
  end

  def schema
    Schema
  end

  private

  def convert_to_array(response)
    attacks = []
    response[:attacks].each do |torn_id, attack|
      attack[:torn_id] = torn_id.to_s.to_i
      attacks << attack
    end
    attacks
  end
end
