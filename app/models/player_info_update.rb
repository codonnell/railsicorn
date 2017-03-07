class PlayerInfoUpdate < ApplicationRecord
  belongs_to :player
  belongs_to :spouse, class_name: 'Player', optional: true
end
