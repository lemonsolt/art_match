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
  devise_scope :gallary do
    post "gallaries/guest_sign_in", to: "gallary/sessions#guest_sign_in"
  end
  # artist
  devise_for :artists,skip: [:passwords],controllers: {
    registrations: "artist/registrations",
    sessions: "artist/sessions"
  }
  devise_scope :artist do
    post "artists/guest_sign_in", to: "artist/sessions#guest_sign_in"
  end
  # ここ迄devise関連


  scope module: :artist do
    root to: "homes#top"
    resources :artists, only: [ :index, :show, :destroy, :edit, :update] do
      resource :gtoa_follows,only: [ :create, :destroy]
      get '/information/edit' => 'artists#edit', on: :member
      patch '/information' => 'artists#update', on: :member
      get :follows, on: :member
      get :followers, on: :member
    end
    resources :portfolios do
      resource :portfolio_bookmarks, only: [ :create, :destroy] do
        get :show, on: :member
      end
    end
    resources :genres, only: [ :show]
    resources :dms, only: [ :show, :create, :destroy]
    resources :dm_rooms, only:[:index]
    resources :searches, only: [ :index] do
      get "result" => "searches#result", on: :collection
    end
  end


  namespace :gallary do
    resources :areas, only: [ :index, :show ]
    resources :searches, only: [ :index] do
      get "result" => "searches#result", on: :collection
    end
    resources :events do
      get '/before_index' => 'events#before_index', on: :collection
      get '/now_index' => 'events#now_index', on: :collection
      get '/after_index' => 'events#after_index', on: :collection
      resource :event_bookmarks, only: [ :create, :destroy]  do
        get :show, on: :member
      end
    end

  end
  # gallary/gallaried/~となるのでmoduleで
  scope module: :gallary do
    resources :gallaries, only: [ :index, :show, :destroy, :update] do
      resource :atog_follows,only: [ :create, :destroy]
      get '/information/edit' => 'gallaries#edit', on: :member
      get :follows, on: :member
      get :followers, on: :member
    end
  end

  namespace :admin do
    root to: "homes#top"
    resources :artists, only: [ :index, :show, :edit, :update]
    resources :gallaries, only: [ :index, :show, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
