require 'test_helper'
require 'pry'

class PlayersControllerTest < ActionDispatch::IntegrationTest
  test 'returns no info when no info is known' do
    create_caller
    post '/players', params: { api_key: api_key, ids: [1] }, as: :json
    assert_equal JSON.dump({}), @response.body
  end

  test 'returns unknown difficulty when attacker has no battle stats' do
    create_caller
    target = create(:player)
    create(:battle_stats_update, player: target)
    post '/players', params: { api_key: api_key, ids: [target.torn_id] }, as: :json
    assert_equal({ target.torn_id.to_s => { 'difficulty' => 'unknown',
      'most_stats_defended_against' => nil, 'least_stats_beaten_by' => nil} },
      JSON.parse(@response.body))
  end

  test 'returns unknown difficulty when defender has no attack info' do
    user = create_caller
    create(:battle_stats_update, player: user.player)
    target = create(:player, least_stats_beaten_by: nil, most_stats_defended_against: nil)
    post '/players', params: { api_key: api_key, ids: [target.torn_id] }, as: :json
    assert_equal({ target.torn_id.to_s => { 'difficulty' => 'unknown',
      'most_stats_defended_against' => nil, 'least_stats_beaten_by' => nil } },
      JSON.parse(@response.body))
  end

  test 'returns the appropriate difficulty with info' do
    user = create_caller
    create(:battle_stats_update, strength: 10.0, dexterity: 10.0, speed: 10.0,
      defense: 10.0, player: user.player)
    target = create(:player, least_stats_beaten_by: 10.0, most_stats_defended_against: nil)
    post '/players', params: { api_key: api_key, ids: [target.torn_id] }, as: :json
    assert_equal({ target.torn_id.to_s => { 'difficulty' => 'easy',
      'most_stats_defended_against' => nil, 'least_stats_beaten_by' => 10.0 } },
      JSON.parse(@response.body))
  end

  test 'returns xanax, refill, and SE info' do
    create_caller
    player = create(:player)
    create(:player_info_update, player: player, xanax_taken: 10, refills: 15,
      stat_enhancers_used: 20)
    post '/players', params: { api_key: api_key, ids: [player.torn_id] }, as: :json
    assert_equal({ player.torn_id.to_s => { 'difficulty' => 'unknown',
      'xanax_taken' => 10, 'refills' => 15, 'stat_enhancers_used' => 20,
      'most_stats_defended_against' => nil, 'least_stats_beaten_by' => nil } },
      JSON.parse(@response.body))
  end

  test 'returns unauthorized error when invalid faction' do
    faction = create(:faction, torn_id: 1)
    create(:user, api_key: api_key, faction: faction)
    post '/players', params: { api_key: api_key, ids: [1] }, as: :json
    assert_equal JSON.dump({ error: 'Unauthorized faction' }), @response.body
  end

  test 'returns unknown api key error on unknown api key' do
    post '/players', params: { api_key: api_key, ids: [1] }, as: :json
    assert_equal JSON.dump({ error: "Unknown API key: #{api_key}" }), @response.body
  end

  private

  def create_caller
    faction = create(:faction, torn_id: 16628)
    player = create(:player, faction: faction)
    create(:user, api_key: api_key, player: player, faction: faction)
  end

  def api_key
    'foo'
  end
  # setup do
  #   @player = players(:one)
  # end

  # test "should get index" do
  #   get players_url, as: :json
  #   assert_response :success
  # end

  # test "should create player" do
  #   assert_difference('Player.count') do
  #     post players_url, params: { player: { torn_id: @player.torn_id, user_id: @player.user_id } }, as: :json
  #   end

  #   assert_response 201
  # end

  # test "should show player" do
  #   get player_url(@player), as: :json
  #   assert_response :success
  # end

  # test "should update player" do
  #   patch player_url(@player), params: { player: { torn_id: @player.torn_id, user_id: @player.user_id } }, as: :json
  #   assert_response 200
  # end

  # test "should destroy player" do
  #   assert_difference('Player.count', -1) do
  #     delete player_url(@player), as: :json
  #   end

  #   assert_response 204
  # end
end
