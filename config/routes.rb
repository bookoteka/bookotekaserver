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
    end
  end

  get "up" => "rails/health#show"
end