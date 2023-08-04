class Artist < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :introduction, length: {in: 1..300}
  validates :is_cold, inclusion: {in: [true, false]}

  # ゲストにあてるアドレスとパスワードの設定
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |artist|
      artist.password = SecureRandom.urlsafe_base64
      artist.password_confirmation = artist.password
      artist.name = "ゲストアーティスト"
    end
  end

end
