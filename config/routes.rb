Rails.application.routes.draw do
  # Strona główna aplikacji (http://localhost:3000) będzie prowadzić do listy książek
  root "ksiazkas#index"

  # Standardowy komplet ścieżek RESTful dla książek
  resources :ksiazkas

  # Sprawdzenie stanu aplikacji
  get "up" => "rails/health#show", as: :rails_health_check
end