class UpdateStalePlayersJob < ActiveJob::Base
  def perform
    Rails.application.executor.wrap do
      active_users = User.active_users
      stale_players = Player.most_stale_players(active_users.size, 2.weeks.ago)
      request_infos = stale_players.zip(active_users)
      Parallel.each(request_infos,
        in_threads: Rails.application.config.request_threads) do |player, user|
        ActiveRecord::Base.connection_pool.with_connection do
          request = ApiRequest.player_info(user.api_key, player.torn_id)
          api_caller = ApiCaller.new(request, RateLimiter.new(user))
          PlayerInfoUpdater.new(api_caller).call
        end
      end
    end
  end
end
