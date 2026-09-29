Rails.application.routes.draw do
  root "ksiazkas#index"

  resources :ksiazkas
  resources :czasopismos

  get "up" => "rails/health#show", as: :rails_health_check

  resources :podsumowania, as: :podsumowanie, only: [:index, :new, :create, :show] do
    member do
      get :plik
    end

    collection do
      get :pobierz
      post :wyslij_email
      delete :usun
    end
  end

  get "up" => "rails/health#show"

  get "ustawienia", to: "ustawienia#index", as: :ustawienia
  get "ustawienia/eksport", to: "ustawienia#eksport", as: :eksport_ustawienia

  post "import_bazy", to: "bazy_imports#create", as: :import_bazy

  resources :gatunki, only: [:create, :destroy]
end