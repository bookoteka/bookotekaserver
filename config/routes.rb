Rails.application.routes.draw do
  # Strona główna aplikacji (http://localhost:3000) będzie prowadzić do listy książek
  root "ksiazkas#index"

  # Standardowy komplet ścieżek RESTful dla książek
  resources :ksiazkas
  resources :czasopismos

  # Sprawdzenie stanu aplikacji
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
end