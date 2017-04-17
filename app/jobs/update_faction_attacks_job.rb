class UpdateFactionAttacksJob < ActiveJob::Base
  def perform
    Rails.application.executor.wrap do
      Parallel.each(Faction.where.not(api_key: nil),
        in_threads: Rails.application.config.request_threads) do |faction|
        ActiveRecord::Base.connection_pool.with_connection do
          request = ApiRequest.faction_attacks(faction.api_key)
          api_caller = ApiCaller.new(request, NoRateLimiter.new)
          AttacksUpdater.new(api_caller).call
        end
      end
    end
  end
end
