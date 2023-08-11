class DmMessage < ApplicationRecord
  belongs_to :artist
  belongs_to :gallary
  belongs_to :dm_room
end
