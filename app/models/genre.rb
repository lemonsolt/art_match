class Genre < ApplicationRecord
  has_many :portfolio_genres,dependent: :destroy, foreign_key: 'genre_id'
  has_many :portfolios, through: :portfolio_genres
  validates :name, presence: true

end
