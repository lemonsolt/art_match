class DmRoom < ApplicationRecord
  belongs_to :artist
  belongs_to :gallary
  has_many :dm_messages, dependent: :destroy
end
