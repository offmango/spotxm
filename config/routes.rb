Spotxm::Application.routes.draw do
    root to: 'channels#index'
    resources :channels, only: [:index, :show]    
    resources :tracks, only: :index
    match 'now_playing', :controller => 'channels', :action => 'now_playing'
end
