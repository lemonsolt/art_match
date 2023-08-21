class AComment < ApplicationRecord

  belongs_to :artist

  validates :title, presence: true
  validates :comment, presence: true
end
