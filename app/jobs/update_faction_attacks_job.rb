class UpdateFactionAttacksJob < ActiveJob::Base
  def perform
    Rails.application.executor.wrap do
      Parallel.each(Faction.where.not(api_key: nil),
        in_threads: Rails.application.config.request_threads) do |faction|
        ActiveRecord::Base.connection_pool.with_connection do
          request_time = DateTime.now
          request = ApiRequest.faction_attacks(faction.api_key)
          api_caller = ApiCaller.new(request, NoRateLimiter.new)
          AttacksUpdater.new(api_caller).call
          faction.update_attributes(last_attack_update: request_time)
        end
      end
    end
  end
end
