require 'test_helper'

class UserRegistrarTest < ActiveSupport::TestCase
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

  def battle_stats_body
    {
      strength: 1.0,
      dexterity: 2.0,
      speed: 3.0,
      defense: 4.0,
      strength_modifier: 10,
      dexterity_modifier: 5,
      speed_modifier: 0,
      defense_modifier: -5,
      strength_info: ['+ 2% Strength from education'],
      dexterity_info: ['+ 2% Dexterity from education'],
      speed_info: ['+ 2% Speed from education'],
      defense_info: ['+ 2% Defense from education']
    }
  end

  def empty_key_resp
    { error: { code: 1, error: 'Key is empty' } }
  end

  def invalid_key_resp
    { error: { code: 2, error: 'Incorrect Key' } }
  end

  def api_key
    'foo'
  end

  test 'creates user, player, faction, and battle stats on valid response' do
    info_request = ApiRequest.player_info(api_key)
    battle_stats_request = ApiRequest.battle_stats(api_key)
    stub_request(:get, info_request.url)
      .to_return(body: JSON.dump(valid_resp))
    stub_request(:get, battle_stats_request.url)
      .to_return(body: JSON.dump(battle_stats_body))
    assert_nil(User.find_by(api_key: api_key))
    assert_nil(Faction.find_by(torn_id: 2013))
    assert_nil(Player.find_by(torn_id: 99177))
    UserRegistrar.new(api_key).call
    assert(User.find_by(api_key: api_key))
    assert(Faction.find_by(torn_id: 2013))
    assert(Player.find_by(torn_id: 99177))
  end

  test 'does not overwrite existing user' do
    info_request = ApiRequest.player_info(api_key)
    battle_stats_request = ApiRequest.battle_stats(api_key)
    stub_request(:get, info_request.url)
      .to_return(body: JSON.dump(valid_resp))
    stub_request(:get, battle_stats_request.url)
      .to_return(body: JSON.dump(battle_stats_body))
    faction = create(:faction)
    create(:user, api_key: api_key, faction_id: faction.id)
    assert_equal(faction.id, User.find_by(api_key: api_key).faction_id)
    UserRegistrar.new(api_key).call
    assert_equal(faction.id, User.find_by(api_key: api_key).faction_id)
  end

  test 'does overwrite existing player\'s user' do
    info_request = ApiRequest.player_info(api_key)
    battle_stats_request = ApiRequest.battle_stats(api_key)
    stub_request(:get, info_request.url)
      .to_return(body: JSON.dump(valid_resp))
    stub_request(:get, battle_stats_request.url)
      .to_return(body: JSON.dump(battle_stats_body))
    player = create(:player, torn_id: 99177)
    old_user = create(:user, player: player)
    assert_not_equal(api_key, old_user.api_key)
    UserRegistrar.new(api_key).call
    assert_equal(api_key, player.reload.user.api_key)
    assert_nil(User.find_by(api_key: old_user.api_key))
  end

  test 'nil on empty key' do
    stub_request(:get, /.*api\.torn\.com.*/)
      .to_return(body: JSON.dump(empty_key_resp))
    assert_nil(UserRegistrar.new(api_key).call)
  end

  test 'nil on incorrect key' do
    stub_request(:get, /.*api\.torn\.com.*/)
      .to_return(body: JSON.dump(invalid_key_resp))
    assert_nil(UserRegistrar.new(api_key).call)
  end

end
