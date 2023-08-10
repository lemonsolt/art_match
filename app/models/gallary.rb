class Gallary < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image
  has_many_attached :gallary_images
  has_many :gallary_events, dependent: :destroy
  has_many :portfolio_bookmarks,dependent: :destroy
  # "a"rtistから"g"allaryへのフォロー
  has_many :atog_follows,dependent: :destroy
  # "g"allaryから"a"rtistへのフォロー
  has_many :gtoa_follows,dependent: :destroy


  validates :name, presence: true
  validates :post_code, presence: true
  validates :address, presence: true
  validates :is_cold, inclusion: {in: [true, false]}

  # ゲストログイン関連
  GUEST_USER_EMAIL = "guest@example.com"
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |gallary|
      gallary.password = SecureRandom.urlsafe_base64
      gallary.password_confirmation = gallary.password
      gallary.name = "ゲストギャラリー"
      gallary.introduction = "ゲスト用アカウントです。"
      gallary.post_code = "0000000"
      gallary.address = "地球上のどこか"
    end
  end
  # 画像
  def image_or_empty
    if self.image.attached? == false
      return "noimage_human.jpg"
    else
      return image
    end
  end

  def already_bookmarked?(portfolio)
    self.portfolio_bookmarks.exists?(portfolio_id: portfolio.id)
  end

  def already_followed?(artist)
    self.gtoa_follows.exists?(artist_id: artist.id)
  end

  # 名前のキーワード検索
  def self.search(keyword)
    if keyword.present?
      where('name LIKE ?', "%#{keyword}%")
    else
      all
    end
  end
  # 地域名（住所）のキーワード検索
  def self.search_area(keyword)
    if keyword.present?
      where('address LIKE ?', "%#{keyword}%")
    else
      all
    end
  end

end
