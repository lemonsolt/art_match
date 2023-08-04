Rails.application.routes.draw do
  # ここからdevise関連
  # admin
  devise_for :admins,skip:[:passwords, :registrations], controllers: {
    sessions: "admin/sessions"
  }
  # gallary
  devise_for :gallaries,skip: [:passwords],controllers: {
    registrations: "gallary/registrations",
    sessions: "gallary/sessions"
  }
  devise_scope :gallaries do
    post 'gallary/guest_sign_in',to: 'gallary/sessions#guest_sign_in'
  end
  # artist
  devise_for :artists,skip: [:passwords],controllers: {
    registrations: "artist/registrations",
    sessions: "artist/sessions"
  }
  devise_scope :artists do
    post 'artist/guest_sign_in', to: 'artist/sessions#guest_sign_in'
  end
  # ここ迄devise関連


  scope module: :artist do
    root to: "homes#top"
    get '/following' => 'atog_follow#show' ,as: 'artist_following'
    get '/followers' => 'gtoa_follow#show' ,as: 'artist_follower'
    resources :artists, only: [ :index, :show, :destroy] do
      get '/information/edit' => 'artists#edit'
      patch '/information' => 'artists#update'
    end
    resources :portfolios
    resources :genres, only: [ :index, :show, :create, :update]
    resources :dms, only: [ :index, :show, :create, :destroy]
    resources :searches, only: [ :index]
    resources :event_bookmarks, only: [ :show, :create, :destroy]
  end


  namespace :gallary do
    # follow関連はurlの表示をartist側と逆になるようこちらでも用意
    get '/following' => 'gtoa_follow#show' ,as: 'following'
    get '/followers' => 'atog_follow#show' ,as: 'follower'
    resources :gallaries, only: [ :index, :show, :destroy] do
      get '/information/edit' => 'gallaries#edit'
      patch '/information' => 'gallaries#update'
    end
    resources :areas, only: [ :index, :show, :create, :update]
    resources :searches, only: [ :index]
    resources :portfolio_bookmarks, only: [ :show, :create, :destroy]
    resources :events do
      get '/before_index' => 'events#before_index', on: :collection
      get '/now_index' => 'events#now_index', on: :collection
      get '/after_index' => 'events#after_index', on: :collection
    end
  end

  namespace :admin do
    root to: "homes#top"
    resources :artists, only: [ :index, :show, :edit, :update]
    resources :gallaries, only: [ :index, :show, :edit, :update]
    resources :genres, only: [ :index, :create, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
