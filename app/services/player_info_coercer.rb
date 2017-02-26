class PlayerInfoCoercer
  def initialize(response)
    @response = response.clone
  end

  def call
    @info = rename_keys(@response, key_coercions)
    coerce_name
    coerce_last_action
    coerce_forum_posts
    coerce_donator
    coerce_refills
    coerce_signup
    remove_excess_attributes
    @info
  end

  def coerce_name
    @info[:name] = @info[:name].to_s
  end

  def coerce_last_action
    num, unit = @info[:last_action].match(/(\d+) (minutes?|hours?|days?) ago/)
                                   .captures
    @info[:last_action] = Integer(num).send(unit).ago
  end

  def coerce_forum_posts
    @info[:forum_posts] ||= 0
  end

  def coerce_donator
    @info[:donator] = !@info[:donator].zero?
  end

  def coerce_refills
    @info[:refills] ||= 0
  end

  def coerce_signup
    @info[:signup] = DateTime.parse @info[:signup]
  end

  def remove_excess_attributes
    @info.each do |k, v|
      @info.delete(k) if v.instance_of?(Hash)
    end
    @info.delete(:status)
  end

  def key_coercions
    # Changed respect, the total bounties personals, and the south africa
    # travel personal
    {
      name: :name,
      player_id: :player,
      signup: :signup,
      last_action: :last_action,
      level: :level,
      awards: :awards,
      friends: :friends,
      enemies: :enemies,
      karma: :karma,
      forum_posts: :forum_posts,
      role: :role,
      donator: :donator,
      life: { maximum: :max_life },
      job: { company_id: :company_id, position: :position },
      married: { spouse_id: :spouse },
      faction: { faction_id: :faction },
      personalstats:
      {
        logins: :logins,
        useractivity: :activity,
        attackslost: :attacks_lost,
        attackswon: :attacks_won,
        attacksdraw: :attacks_draw,
        highestbeaten: :highest_beaten,
        bestkillstreak: :best_kill_streak,
        defendslost: :defends_lost,
        defendswon: :defends_won,
        defendsstalemated: :defends_draw,
        xantaken: :xan_taken,
        exttaken: :ecstasy_taken,
        traveltimes: :times_traveled,
        networth: :networth,
        refills: :refills,
        statenhancersused: :stat_enhancers_used,
        medicalitemsused: :medical_items_used,
        weaponsbought: :weapons_bought,
        bazaarcustomers: :bazaar_customers,
        bazaarsales: :bazaar_sales,
        bazaarprofit: :bazaar_profit,
        pointsbought: :points_bought,
        pointssold: :points_sold,
        itemsboughtabroad: :items_bought_abroad,
        itemsbought: :items_bought,
        trades: :trades,
        itemssent: :items_sent,
        auctionswon: :auctions_won,
        auctionsells: :auctions_sold,
        moneymugged: :money_mugged,
        attacksstealthed: :attacks_stealthed,
        attackcriticalhits: :critical_hits,
        respectforfaction: :respect,
        roundsfired: :rounds_fired,
        yourunaway: :attacks_ran_away,
        theyrunaway: :defends_ran_away,
        peoplebusted: :people_busted,
        failedbusts: :failed_busts,
        peoplebought: :bails_bought,
        peopleboughtspent: :bails_spent,
        virusescoded: :viruses_coded,
        cityfinds: :city_finds,
        bountiesplaced: :bounties_placed,
        bountiesreceived: :bounties_received,
        bountiescollected: :bounties_collected,
        totalbountyreward: :bounty_rewards,
        totalbountyspent: :bounties_spent,
        revives: :revives,
        revivesreceived: :revives_received,
        trainsreceived: :trains_received,
        drugsused: :drugs_taken,
        overdosed: :overdoses,
        meritsbought: :merits_bought,
        personalsplaced: :personals_placed,
        classifiedadsplaced: :classifieds_placed,
        mailssent: :mail_sent,
        friendmailssent: :friend_mail_sent,
        factionmailssent: :faction_mail_sent,
        companymailssent: :company_mail_sent,
        spousemailssent: :spouse_mail_sent,
        largestmug: :largest_mug,
        cantaken: :canabis_taken,
        kettaken: :ketamine_taken,
        lsdtaken: :lsd_taken,
        opitaken: :opium_taken,
        shrtaken: :shrooms_taken,
        spetaken: :speed_taken,
        pcptaken: :pcp_taken,
        victaken: :vicodin_taken,
        chahits: :mechanical_hits,
        heahits: :artillery_hits,
        axehits: :clubbed_hits,
        grehits: :temp_hits,
        machits: :machine_gun_hits,
        pishits: :pistol_hits,
        rifhits: :rifle_hits,
        shohits: :shotgun_hits,
        smghits: :smg_hits,
        piehits: :piercing_hits,
        slahits: :slashing_hits,
        argtravel: :argentina_travel,
        mextravel: :mexico_travel,
        dubtravel: :dubai_travel,
        hawtravel: :hawaii_travel,
        japtravel: :japan_travel,
        lontravel: :london_travel,
        soutravel: :south_africa_travel,
        switravel: :switzerland_travel,
        chitravel: :china_travel,
        cantravel: :canada_travel,
        caytravel: :caymans_travel,
        dumpfinds: :dump_finds,
        dumpsearches: :dump_searches,
        itemsdumped: :items_dumped,
        daysbeendonator: :days_as_donator,
        jailed: :times_jailed,
        hospital: :times_hospitalized,
        attacksassisted: :attacks_assisted,
        bloodwithdrawn: :blood_withdrawn,
        missioncreditsearned: :mission_credits,
        contractscompleted: :contracts_completed,
        dukecontractscompleted: :duke_contracts_completed,
        missionscompleted: :missions_completed
      }
    }
  end

  def rename_keys(source, guide)
    rename_keys_helper({}, source, guide)
  end

  def rename_keys_helper(dest, source, guide)
    source.each do |k, v|
      if v.is_a?(Hash) && guide[k]
        rename_keys_helper(dest, source[k], guide[k])
      else
        dest[guide[k]] = v
      end
    end
    dest
  end
end
