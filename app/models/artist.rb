class Artist < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image
  has_many :portfolios, dependent: :destroy
  has_many :event_bookmarks, dependent: :destroy

  # "a"rtistから"g"allaryへのフォロー
  has_many :atog_follows,dependent: :destroy
  # "g"allaryから"a"rtistへのフォロー
  has_many :gtoa_follows,dependent: :destroy

  has_many :dm_rooms, dependent: :destroy
  has_many :gallaries, through: :dm_rooms
  has_many :dm_messages, dependent: :destroy

  validates :name, presence: true
  validates :introduction, length: {in: 1..500}
  validates :is_cold, inclusion: {in: [true, false]}
  validates :is_lock, inclusion: {in: [true, false]}



  # ゲストにあてるアドレスとパスワードの設定
  GUEST_USER_EMAIL = "guest@example.com"
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |artist|
      artist.password = SecureRandom.urlsafe_base64
      artist.password_confirmation = artist.password
      artist.name = "ゲストアーティスト"
      artist.introduction = "ゲスト用アカウントです。
        このアカウントでは投稿とゲストギャラリーへのみDMが送れます。"
    end
  end
# 画像の有無で違う表示に
  def artist_image_or_empty
    if self.image.attached? == false
      return "noimage_human.jpg"
    else
      return image
    end
  end

  def image_or_empty
    if self.image.attached? == false
      return "noimage_human.jpg"
    else
      return image
    end
  end
# 既にブックマークしてるか否か
  def already_bookmarked?(gallary_event)
    self.event_bookmarks.exists?(gallary_event_id: gallary_event.id)
  end
# 既にフォローしてるか否か
  def already_followed?(gallary)
    self.atog_follows.exists?(gallary_id: gallary.id)
  end

  # 名前のキーワード検索
  def self.search(keyword)
    if keyword.present?
      where('name LIKE ?', "%#{keyword}%")
    else
      all
    end
  end

end
