class ChangeRelevantPlayerInfoToOuterJoin < ActiveRecord::Migration[5.0]
  def up
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

  def down
    execute 'DROP VIEW relevant_player_infos'
    execute <<-SQL
    CREATE VIEW relevant_player_infos AS
    SELECT
      players.torn_id, players.least_stats_beaten_by, players.most_stats_defended_against,
      info.player_id, info.xanax_taken, info.refills, info.stat_enhancers_used
    FROM players
    INNER JOIN (
      SELECT DISTINCT ON (player_id)
             *
      FROM player_info_updates
      ORDER BY player_id, timestamp DESC) info
    ON players.id = info.player_id
    SQL
  end
end
