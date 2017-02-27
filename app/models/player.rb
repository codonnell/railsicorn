class Player < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :faction, optional: true
  has_many :battle_stats_updates
  has_many :player_info_updates, foreign_key: 'player_id'
  has_many :attacks, foreign_key: 'attacker_id'
  has_many :defends, class_name: 'Attack', foreign_key: 'defender_id'

  def active_user?
    user && user.api_key
  end

  def battle_stats
    BattleStatsUpdate.where(player: self).order(timestamp: :desc).limit(1).first
  end

  def total_battle_stats
    stats = battle_stats
    return nil if stats.nil?
    stats[:strength] * stats[:strength_modifier] +
      stats[:dexterity] * stats[:dexterity_modifier] +
      stats[:speed] * stats[:speed_modifier] +
      stats[:defense] * stats[:defense_modifier]
  end
end
