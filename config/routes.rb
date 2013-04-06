require 'sidekiq/web'

Spotxm::Application.routes.draw do
 	devise_for :users

    resources :channels, only: [:index, :show]    
    resources :tracks, only: :index
    match 'now_playing', :controller => 'channels', :action => 'now_playing'
    root to: 'tracks#search'
    
    constraint = lambda { |request| request.env["warden"].authenticate? and request.env['warden'].user.admin? }
	constraints constraint do
    	mount Sidekiq::Web => '/sidekiq'
    end
end
