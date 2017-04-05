class UpdateFactionAttacksJob < ActiveJob::Base
  def perform
    Parallel.each(Faction.where.not(api_key: nil),
                  in_threads: Rails.application.config.request_threads) do |faction|
      request = ApiRequest.faction_attacks(faction.api_key)
      api_caller = ApiCaller.new(request, NoRateLimiter.new)
      AttacksUpdater.new(api_caller).call
    end
  end
end
