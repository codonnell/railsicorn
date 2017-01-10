require 'dry-validation'

class BattleStatsValidator < Validator
  Schema = Dry::Validation.Schema do
    required(:strength) { float? & gt?(0) }
    required(:dexterity) { float? & gt?(0) }
    required(:speed) { float? & gt?(0) }
    required(:defense) { float? & gt?(0) }
    required(:strength_modifier) { int? }
    required(:dexterity_modifier) { int? }
    required(:speed_modifier) { int? }
    required(:defense_modifier) { int? }
  end

  def schema
    Schema
  end
end
