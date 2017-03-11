class UpdateFactionAttacksJob < ActiveJob::Base
  def perform
    Faction.where.not(api_key: nil).each do |faction|
      request = ApiRequest.faction_attacks(faction.api_key)
      api_caller = ApiCaller.new(request, NoRateLimiter.new)
      AttacksUpdater.new(api_caller).call
    end
  end
end
