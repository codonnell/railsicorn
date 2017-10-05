FactoryGirl.define do

  factory :battle_stats_update do
    strength 10.0
    dexterity 10.0
    speed 10.0
    defense 10.0
    strength_modifier 1.0
    dexterity_modifier 1.0
    speed_modifier 1.0
    defense_modifier 1.0
    timestamp { DateTime.now }
    player
  end

  sequence :attack_id do |n|
    n
  end

  factory :attack do
    torn_id { generate(:attack_id) }
    timestamp_started "2017-02-20 17:07:17"
    timestamp_ended "2017-02-20 17:07:17"
    association :attacker, factory: :player
    association :defender, factory: :player
    result "Hospitalize"
    respect_gain 1.5
    group_attack false
  end

  sequence :player_id do |n|
    n
  end

  sequence :faction_id do |n|
    n
  end

  sequence :api_key do |n|
    "key#{n}"
  end

  factory :player_info_update do
    timestamp { DateTime.now }
    name { "Player#{generate(:player_id)}" }
    level 1
    last_action { 3.days.ago }
    player
    awards 0
    friends 0
    enemies 0
    karma 0
    forum_posts 0
    role 'Civilian'
    donator true
    max_life 100
    company_id 0
    position 'Employee'
    association :spouse, factory: :player
    logins 1
    activity 1
  end

  factory :player do
    torn_id { generate(:player_id) }
    signup { 1.week.ago }
    least_stats_beaten_by nil
    most_stats_defended_against nil
  end

  factory :user do
    api_key { generate(:api_key) }
    faction
    requests_available 10
    player
  end

  factory :faction do
    torn_id { generate(:faction_id) }
    api_key { generate(:api_key) }
  end
end
