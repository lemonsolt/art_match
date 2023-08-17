class Guestuser::DataGuest

  # guestartistの投稿を削除
  def self.portfolio_reset
    artist = Artist.find_by(email: "guest@example.com")
    artist.portfoilos.destroy_all
  end
  # guestgallaryの投稿を削除
  def self.event_reset
    gallary = Gallary.find_by(email: "guest@example.com")
    gallary.gallary_events.destroy_all
  end
end