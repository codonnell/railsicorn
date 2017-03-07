require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton

scheduler.every '6s' do
  UpdateFactionAttacksJob.perform_now
end

scheduler.every '30s' do
  UpdateStalePlayersJob.perform_now
end

scheduler.every '1m' do
  IncRequestsAvailableJob.perform_now
end
