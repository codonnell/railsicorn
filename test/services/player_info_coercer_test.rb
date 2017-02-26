require 'test_helper'

class PlayerInfoCoercerTest < ActiveSupport::TestCase
  def min_resp
    {
      donator: 0,
      last_action: '0 minutes ago',
      signup: '2005-07-19 03:00:34'
    }
  end

  def valid_resp
    {
      rank: "Invincible Killer",
      level: 100,
      gender: "Male",
      property: "Private Island",
      signup: "2005-07-19 03:00:34",
      awards: 420,
      friends: 1410,
      enemies: 219,
      forum_posts: 3368,
      karma: 1965,
      age: 4195,
      role: "Civilian",
      donator: 1,
      player_id: 99177,
      name: "BodyBagger",
      property_id: 618737,
      last_action: "17 minutes ago",
      life:
      {
        current: 7500,
        maximum: 7500,
        increment: 375,
        interval: 300,
        ticktime: 63,
        fulltime: 0
      },
      status: ["Okay", ""],
      job:
      {position: "Director", company_id: 19303, company_name: "BodyBagger&#39;s Oil"},
      faction:
      {
        position: "Member",
        faction_id: 2013,
        days_in_faction: 939,
        faction_name: "Subversive  Alliance"
      },
      married: {spouse_id: 158720, spouse_name: "Brainwave", duration: 3346},
      icons:
      {
        icon5: "Level 100",
        icon6: "Male",
        icon3: "Donator",
        icon4: "Subscriber",
        icon8: "Married - To Brainwave",
        icon27: "Company - Director of BodyBagger&#39;s Oil (Oil Rig)",
        icon9: "Faction - Member of Subversive  Alliance",
        icon35: "Bazaar - This person has items in their bazaar for sale"
      },
      personalstats:
      {
        bazaarcustomers: 3633,
        bazaarsales: 157786,
        bazaarprofit: 540977091068,
        useractivity: 28959120,
        itemsbought: 903,
        pointsbought: 123546,
        itemsboughtabroad: 15777,
        weaponsbought: 200,
        trades: 7425,
        itemssent: 306,
        auctionswon: 100,
        auctionsells: 1,
        pointssold: 411394,
        attackswon: 39107,
        attackslost: 508,
        attacksdraw: 2554,
        bestkillstreak: 2539,
        moneymugged: 92515961600,
        attacksstealthed: 27480,
        attackcriticalhits: 36453,
        respectforfaction: 52777,
        defendswon: 30534,
        defendslost: 2263,
        defendsstalemated: 633,
        roundsfired: 177815,
        yourunaway: 3936,
        theyrunaway: 1034,
        highestbeaten: 100,
        peoplebusted: 10005,
        failedbusts: 2326,
        peoplebought: 532,
        peopleboughtspent: 42285700,
        virusescoded: 591,
        cityfinds: 240,
        traveltimes: 1301,
        bountiesplaced: 119,
        bountiesreceived: 167,
        bountiescollected: 3550,
        totalbountyreward: 4288187743,
        revives: 1108,
        revivesreceived: 533,
        medicalitemsused: 30126,
        statenhancersused: 4813,
        trainsreceived: 0,
        totalbountyspent: 49826666,
        drugsused: 5366,
        overdosed: 124,
        meritsbought: 50,
        logins: 7979,
        personalsplaced: 0,
        classifiedadsplaced: 24,
        mailssent: 73451,
        friendmailssent: 8084,
        factionmailssent: 13498,
        companymailssent: 4755,
        spousemailssent: 7581,
        largestmug: 686981142,
        cantaken: 1666,
        exttaken: 50,
        kettaken: 50,
        lsdtaken: 309,
        opitaken: 50,
        shrtaken: 50,
        spetaken: 50,
        pcptaken: 50,
        xantaken: 2044,
        victaken: 1047,
        chahits: 505,
        heahits: 2963,
        axehits: 19029,
        grehits: 523,
        machits: 501,
        pishits: 739,
        rifhits: 2027,
        shohits: 4585,
        smghits: 1853,
        piehits: 2431,
        slahits: 1942,
        argtravel: 50,
        mextravel: 54,
        dubtravel: 50,
        hawtravel: 55,
        japtravel: 54,
        lontravel: 101,
        soutravel: 215,
        switravel: 330,
        chitravel: 50,
        cantravel: 50,
        dumpfinds: 1081,
        dumpsearches: 1082,
        itemsdumped: 5003,
        daysbeendonator: 1880,
        caytravel: 50,
        jailed: 3848,
        hospital: 1274,
        attacksassisted: 41,
        bloodwithdrawn: 2978,
        networth: 292601715944,
        missioncreditsearned: 8582,
        contractscompleted: 391,
        dukecontractscompleted: 391,
        missionscompleted: 1,
        refills: 2004
      }
    }
  end

  def coerced_resp
    {
      :level=>100,
      :awards=>420,
      :friends=>1410,
      :enemies=>219,
      :forum_posts=>3368,
      :karma=>1965,
      :signup=> DateTime.parse("2005-07-19 03:00:34"),
      :role=>"Civilian",
      :donator=>true,
      :player=>99177,
      :name=>"BodyBagger",
      :last_action=> 17.minutes.ago,
      :max_life=>7500,
      :position=>"Director",
      :company_id=>19303,
      :faction=>2013,
      :spouse=>158720,
      :bazaar_customers=>3633,
      :bazaar_sales=>157786,
      :bazaar_profit=>540977091068,
      :activity=>28959120,
      :items_bought=>903,
      :points_bought=>123546,
      :items_bought_abroad=>15777,
      :weapons_bought=>200,
      :trades=>7425,
      :items_sent=>306,
      :auctions_won=>100,
      :auctions_sold=>1,
      :points_sold=>411394,
      :attacks_won=>39107,
      :attacks_lost=>508,
      :attacks_draw=>2554,
      :best_kill_streak=>2539,
      :money_mugged=>92515961600,
      :attacks_stealthed=>27480,
      :critical_hits=>36453,
      :respect=>52777,
      :defends_won=>30534,
      :defends_lost=>2263,
      :defends_draw=>633,
      :rounds_fired=>177815,
      :attacks_ran_away=>3936,
      :defends_ran_away=>1034,
      :highest_beaten=>100,
      :people_busted=>10005,
      :failed_busts=>2326,
      :bails_bought=>532,
      :bails_spent=>42285700,
      :viruses_coded=>591,
      :city_finds=>240,
      :times_traveled=>1301,
      :bounties_placed=>119,
      :bounties_received=>167,
      :bounties_collected=>3550,
      :bounty_rewards=>4288187743,
      :revives=>1108,
      :revives_received=>533,
      :medical_items_used=>30126,
      :stat_enhancers_used=>4813,
      :trains_received=>0,
      :bounties_spent=>49826666,
      :drugs_taken=>5366,
      :overdoses=>124,
      :merits_bought=>50,
      :logins=>7979,
      :personals_placed=>0,
      :classifieds_placed=>24,
      :mail_sent=>73451,
      :friend_mail_sent=>8084,
      :faction_mail_sent=>13498,
      :company_mail_sent=>4755,
      :spouse_mail_sent=>7581,
      :largest_mug=>686981142,
      :canabis_taken=>1666,
      :ecstasy_taken=>50,
      :ketamine_taken=>50,
      :lsd_taken=>309,
      :opium_taken=>50,
      :shrooms_taken=>50,
      :speed_taken=>50,
      :pcp_taken=>50,
      :xan_taken=>2044,
      :vicodin_taken=>1047,
      :mechanical_hits=>505,
      :artillery_hits=>2963,
      :clubbed_hits=>19029,
      :temp_hits=>523,
      :machine_gun_hits=>501,
      :pistol_hits=>739,
      :rifle_hits=>2027,
      :shotgun_hits=>4585,
      :smg_hits=>1853,
      :piercing_hits=>2431,
      :slashing_hits=>1942,
      :argentina_travel=>50,
      :mexico_travel=>54,
      :dubai_travel=>50,
      :hawaii_travel=>55,
      :japan_travel=>54,
      :london_travel=>101,
      :south_africa_travel=>215,
      :switzerland_travel=>330,
      :china_travel=>50,
      :canada_travel=>50,
      :dump_finds=>1081,
      :dump_searches=>1082,
      :items_dumped=>5003,
      :days_as_donator=>1880,
      :caymans_travel=>50,
      :times_jailed=>3848,
      :times_hospitalized=>1274,
      :attacks_assisted=>41,
      :blood_withdrawn=>2978,
      :networth=>292601715944,
      :mission_credits=>8582,
      :contracts_completed=>391,
      :duke_contracts_completed=>391,
      :missions_completed=>1,
      :refills=>2004
    }
  end

  test 'coerces keys correctly' do
    assert_equal(
      coerced_resp.keys.to_set,
      PlayerInfoCoercer.new(valid_resp).call.keys.to_set
    )
  end

  test 'coerces last action correctly' do
    assert_in_delta(
      0.minutes.ago,
      PlayerInfoCoercer.new(min_resp.merge({ last_action: '0 minutes ago' })).call[:last_action],
      0.1
    )
    assert_in_delta(
      1.hour.ago,
      PlayerInfoCoercer.new(min_resp.merge({ last_action: '1 hour ago' })).call[:last_action],
      0.1
    )
    assert_in_delta(
      1.day.ago,
      PlayerInfoCoercer.new(min_resp.merge({ last_action: '1 day ago' })).call[:last_action],
      0.1
    )
    assert_in_delta(
      4.days.ago,
      PlayerInfoCoercer.new(min_resp.merge({ last_action: '4 days ago' })).call[:last_action],
      0.1
    )
  end

  test 'coerces integer names' do
    assert_equal(
      "1234",
      PlayerInfoCoercer.new(min_resp.merge({ name: 1234 })).call[:name])
  end

  test 'coerces nil forum_posts' do
    assert_equal(0, PlayerInfoCoercer.new(min_resp.merge({ forum_posts: nil })).call[:forum_posts])
  end

  test 'coerces nil refills' do
    assert_equal(0, PlayerInfoCoercer.new(min_resp.merge({ refills: nil })).call[:refills])
  end
end
