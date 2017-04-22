class Player < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :faction, optional: true
  has_one :relevant_player_info
  has_many :battle_stats_updates, dependent: :destroy
  has_many :player_info_updates, foreign_key: 'player_id', dependent: :destroy
  has_many :attacks, foreign_key: 'attacker_id', dependent: :destroy
  has_many :defends, class_name: 'Attack', foreign_key: 'defender_id', dependent: :destroy

  def active_user?
    user && user.api_key
  end

  def battle_stats
    @battle_stats ||= BattleStatsUpdate.where(player: self).order(timestamp: :desc).limit(1).first
  end

  def total_battle_stats
    stats = battle_stats
    return nil if stats.nil?
    @total_battle_stats ||=
      stats[:strength] * stats[:strength_modifier] +
      stats[:dexterity] * stats[:dexterity_modifier] +
      stats[:speed] * stats[:speed_modifier] +
      stats[:defense] * stats[:defense_modifier]
  end

  def self.most_stale_players(n, age_cutoff)
    no_info_players = no_info_players(n)
    return no_info_players.to_a if no_info_players.size == n
    stale_info_players = stale_info_players(n - no_info_players.size, age_cutoff)
    no_info_players.to_a.concat(stale_info_players.to_a)
  end

  def info
    PlayerInfoUpdate.where(player: self).order(timestamp: :desc).limit(1).first
  end

  def self.no_info_players(n)
    left_outer_joins(:player_info_updates).where(player_info_updates: { id: nil }).limit(n)
  end

  def self.stale_info_players(n, age_cutoff)
    Player.find_by_sql([
      %{SELECT players.* FROM players INNER JOIN
            (
             SELECT player_id, max(timestamp) AS max_timestamp
             FROM player_info_updates
             GROUP BY player_id
            ) AS subquery
        ON players.id = subquery.player_id
        WHERE subquery.max_timestamp < ?
        ORDER BY subquery.max_timestamp
        LIMIT(?)}, age_cutoff, n])
  end

  def difficulty(target)
    my_stats = total_battle_stats
    return :unknown unless my_stats
    target[:least_stats_beaten_by] ||= Float::MAX
    target[:most_stats_defended_against] ||= Float::MIN
    # plus and minus ones are to deal with floating point quirks
    if my_stats > target[:least_stats_beaten_by] - 1
      if my_stats < target[:most_stats_defended_against] + 1
        :medium
      else
        :easy
      end
    else
      if my_stats < target[:most_stats_defended_against] + 1
        :impossible
      else
        :unknown
      end
    end
  end
end
