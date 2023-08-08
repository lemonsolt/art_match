class Artist < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image
  has_many :portfolios, dependent: :destroy
  has_many :event_bookmarks, dependent: :destroy

  validates :name, presence: true
  validates :introduction, length: {in: 1..500}
  validates :is_cold, inclusion: {in: [true, false]}



  # ゲストにあてるアドレスとパスワードの設定
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |artist|
      artist.password = SecureRandom.urlsafe_base64
      artist.password_confirmation = artist.password
      artist.name = "ゲストアーティスト"
    end
  end

  def artist_image_or_empty
    if self.image.attached? == false
      return "noimage_human.jpg"
    else
      return image
    end
  end
  
  def already_bookmarked?(gallary_event)
    self.event_bookmarks.exists?(gallary_event_id: gallary_event.id)
  end

end
