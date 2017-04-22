class RelevantPlayerInfo < ActiveRecord::Base
  self.primary_key = 'torn_id'

  belongs_to :player
end
