class UpdateFactionAttacksJob < ActiveJob::Base
  def perform
    Faction.all.each do |faction|
      next unless faction.api_key
      request = ApiRequest.faction_attacks(faction.api_key)
      api_caller = ApiCaller.new(request, NoRateLimiter.new)
      AttacksUpdater.new(api_caller).call
    end
  end
end
