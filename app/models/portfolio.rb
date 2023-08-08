class Portfolio < ApplicationRecord
  belongs_to :artist
  has_many :portfolio_genres,dependent: :destroy,foreign_key: 'portfolio_id'
  has_many :genres,through: :portfolio_genres
  has_many :portfolio_bookmarks,dependent: :destroy
  has_one_attached :image


  def image_or_empty
    if self.image.attached? == false
      return "noimage_camera.jpg"
    else
      return image
    end
  end

   # ジャンルタグ保存
  def save_genre(sent_genres)
    current_genres = self.genres.pluck(:name) unless self.genres.nil?
    old_genres = current_genres - sent_genres
    new_genres = sent_genres - current_genres

    # 古いジャンルの削除
    old_genres.each do |old|
      self.genres.delete Genre.find_by(name: old)
    end

    # 新しいジャンルの保存
    new_genres.each do |new|
      new_portfolio_genre = Genre.find_or_create_by(name: new)
      self.genres << new_portfolio_genre
    end

  end
end
