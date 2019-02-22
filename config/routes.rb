Rails.application.routes.draw do
  root "boards#index"

  resources :boards do
    resources :songs
  end

  resources :artists do
    resources :songs
  end

  get "/boards/:board_id/song_list", to: "songs#song_list", as: "song_list"
  get "/boards/:board_id/add_song/:id", to: "songs#add_song_billboard", as: "add_song_billboard"
end
