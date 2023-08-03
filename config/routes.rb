Rails.application.routes.draw do
  devise_for :admins,skip:[:passwords, :registrations], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :gallaries,skip: [:passwords],controllers: {
    registrations: "gallary/registrations",
    sessions: "gallary/sessions"
  }
  devise_scope :gallaries do
    post 'gallary/guest_sign_in',to: 'gallary/sessions#guest_sign_in'
  end
  devise_for :artists,skip: [:passwords],controllers: {
    registrations: "artist/registrations",
    sessions: "artist/sessions"
  }
  devise_scope :artists do
    post 'artist/guest_sign_in', to: 'artist/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
