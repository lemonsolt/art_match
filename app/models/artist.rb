class Artist < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |artist|
      artist.password = SecureRandom.urlsafe_base64
      artist.password_confirmation = artist.password
      artist.name = "ゲストアーティスト"
    end
  end
end
