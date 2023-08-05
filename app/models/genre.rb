class Genre < ApplicationRecord
  has_many :genre_relationship
  has_many :portfolio, through: :genre_relationship
end
