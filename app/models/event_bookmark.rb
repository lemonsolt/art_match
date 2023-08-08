class EventBookmark < ApplicationRecord
  belongs_to :artist
  belongs_to :gallary_event

  validates_uniqueness_of :gallary_event_id, scope: :artist_id
end
