class GenreRelationship < ApplicationRecord
  belongs_to :portfolio
  belongs_to :genre
end
