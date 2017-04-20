require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton

# Prevent scheduler from running on rails console and rake tasks
# unless defined?(Rails::Console) || File.split($0).last == 'rake'
#   scheduler.every '6s' do
#     UpdateFactionAttacksJob.perform_now
#   end

#   scheduler.every '30s' do
#     UpdateStalePlayersJob.perform_now
#   end

#   scheduler.every '1m' do
#     IncRequestsAvailableJob.perform_now
#   end
# end
