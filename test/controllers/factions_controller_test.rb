require 'test_helper'

class FactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @faction = factions(:one)
  end

  test "should get index" do
    get factions_url, as: :json
    assert_response :success
  end

  test "should create faction" do
    assert_difference('Faction.count') do
      post factions_url, params: { faction: { api_key: @faction.api_key, torn_id: @faction.torn_id } }, as: :json
    end

    assert_response 201
  end

  test "should show faction" do
    get faction_url(@faction), as: :json
    assert_response :success
  end

  test "should update faction" do
    patch faction_url(@faction), params: { faction: { api_key: @faction.api_key, torn_id: @faction.torn_id } }, as: :json
    assert_response 200
  end

  test "should destroy faction" do
    assert_difference('Faction.count', -1) do
      delete faction_url(@faction), as: :json
    end

    assert_response 204
  end
end
