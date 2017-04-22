class PlayerInfoUpdate < ApplicationRecord
  belongs_to :player
  belongs_to :spouse, class_name: 'Player', optional: true

  def self.denull
    cols = [:logins, :activity, :attacks_won, :attacks_draw, :attacks_lost,
      :highest_beaten, :best_kill_streak, :defends_lost, :defends_won,
      :defends_draw, :xanax_taken, :ecstasy_taken, :times_traveled, :networth,
      :refills, :stat_enhancers_used, :medical_items_used, :weapons_bought,
      :bazaar_customers, :bazaar_sales, :bazaar_profit, :points_bought,
      :points_sold, :items_bought_abroad, :items_bought, :trades, :items_sent,
      :auctions_won, :auctions_sold, :money_mugged, :attacks_stealthed,
      :critical_hits, :respect, :rounds_fired, :attacks_ran_away,
      :defends_ran_away, :people_busted, :failed_busts, :bails_bought,
      :bails_spent, :viruses_coded, :city_finds, :bounties_placed,
      :bounties_received, :bounties_collected, :bounty_rewards, :bounties_spent,
      :revives, :revives_received, :trains_received, :drugs_taken, :overdoses,
      :merits_bought, :personals_placed, :classifieds_placed, :mail_sent,
      :friend_mail_sent, :faction_mail_sent, :company_mail_sent,
      :spouse_mail_sent, :largest_mug, :canabis_taken, :ketamine_taken,
      :lsd_taken, :opium_taken, :shrooms_taken, :speed_taken, :pcp_taken,
      :vicodin_taken, :mechanical_hits, :artillery_hits, :clubbed_hits,
      :temp_hits, :machine_gun_hits, :pistol_hits, :rifle_hits, :shotgun_hits,
      :smg_hits, :piercing_hits, :slashing_hits, :argentina_travel,
      :mexico_travel, :dubai_travel, :hawaii_travel, :japan_travel,
      :london_travel, :south_africa_travel, :switzerland_travel, :china_travel,
      :canada_travel, :caymans_travel, :dump_finds, :dump_searches, :items_dumped,
      :days_as_donator, :times_jailed, :times_hospitalized, :attacks_assisted,
      :blood_withdrawn, :mission_credits, :contracts_completed,
      :duke_contracts_completed, :missions_completed, :medical_items_stolen,
      :spies_done, :best_damage, :kill_streak, :one_hit_kills, :money_invested,
      :invested_profit, :attack_misses, :attack_damage, :attack_hits]
    cols.each { |col| denull_col(col) }
  end

  def self.denull_col(col)
    ActiveRecord::Base.connection.execute("UPDATE player_info_updates SET #{col} = 0 WHERE #{col} IS NULL")
  end
end
