class Portfolio < ApplicationRecord
  belongs_to :artist
  has_many :genre_relationship
  has_many :genre,through: :genre_relationship
  has_one_attached :image


  def image_or_empty
    if self.image.attached? == false
      return "noimage_camera.jpg"
    else
      return image
    end
  end
end
