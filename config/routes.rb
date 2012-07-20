Spotxm::Application.routes.draw do
    root to: 'channels#index'
    match 'channels/find_channel' => 'channels#find_channel'
    resources :channels, only: [:index, :show]    
end
