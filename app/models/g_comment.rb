class GComment < ApplicationRecord


  belongs_to :gallary

  validates :title, presence: true
  validates :comment, presence: true
end
