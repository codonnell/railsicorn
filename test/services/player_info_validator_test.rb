require 'test_helper'

class PlayerInfoValidatorTest < ActiveSupport::TestCase
  def valid_schema_h
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
        medstolen: 5,
        spydone: 10,
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
        refills: 2004,
        bestdamage: 6086,
        killstreak: 0,
        moneyinvested: 1000000,
        investedprofit: 100000000,
        onehitkills: 1000,
        attackmisses: 7283,
        attackdamage: 10000000,
        attackhits: 10000
      }
    }
  end

  test 'valid response is valid' do
    assert PlayerInfoValidator.new(valid_schema_h).valid?
  end

  test 'string status is valid' do
    string_status = valid_schema_h
    string_status[:status] = 'Traveling'
    assert PlayerInfoValidator.new(string_status).valid?
  end

  test 'nil refills is valid' do
    nil_refills = valid_schema_h
    nil_refills[:refills] = nil
    assert PlayerInfoValidator.new(nil_refills).valid?
  end

  test 'nil forum posts is valid' do
    nil_forum_posts = valid_schema_h
    nil_forum_posts[:forum_posts] = nil
    assert PlayerInfoValidator.new(nil_forum_posts).valid?
  end

  test 'integer name is valid' do
    int_name = valid_schema_h
    int_name[:name] = 1
    assert PlayerInfoValidator.new(int_name).valid?
  end

  test 'minimal response is valid' do
    min_schema_h = valid_schema_h.clone
    min_schema_h[:personalstats] = {}
    assert PlayerInfoValidator.new(min_schema_h).valid?
  end

  test 'nil job is valid' do
    min_schema_h = valid_schema_h.clone
    min_schema_h[:job] = nil
    assert PlayerInfoValidator.new(min_schema_h).valid?
  end
end
