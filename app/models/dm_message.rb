class DmMessage < ApplicationRecord
  belongs_to :artist, optional: true
  belongs_to :gallary, optional: true
  belongs_to :dm_room
end
