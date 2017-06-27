class ChangeRelevantPlayerInfosToLateralJoin < ActiveRecord::Migration[5.0]
  def up
    execute 'DROP VIEW relevant_player_infos'
    execute <<-SQL
    CREATE VIEW relevant_player_infos AS
    SELECT
      p.torn_id, p.id AS player_id, p.least_stats_beaten_by, p.most_stats_defended_against,
      i.xanax_taken, i.refills, i.stat_enhancers_used
    FROM players p
    LEFT OUTER JOIN LATERAL
      (SELECT *
      FROM player_info_updates i2
      WHERE i2.player_id = p.id
      ORDER BY i2.timestamp DESC
      LIMIT 1) i
    ON true;
    SQL
  end

  def down
    execute 'DROP VIEW relevant_player_infos'
    execute <<-SQL
    CREATE VIEW relevant_player_infos AS
    SELECT
      players.torn_id, players.id AS player_id, players.least_stats_beaten_by,
      players.most_stats_defended_against, info.xanax_taken, info.refills, info.stat_enhancers_used
    FROM players
    LEFT OUTER JOIN (
      SELECT DISTINCT ON (player_id)
             *
      FROM player_info_updates
      ORDER BY player_id, timestamp DESC) info
    ON players.id = info.player_id
    SQL
  end
end
