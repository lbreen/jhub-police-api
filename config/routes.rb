Rails.application.routes.draw do
  root to: "pages#home"

  # get 'senior_leadership', to: 'pages#senior_leadership'
  # get 'neighbourhood_policing', to: 'pages#neighbourhood_policing'
  # get 'crime_data', to: 'pages#crime_data'

  resources :forces, only: [:index, :show]
  resources :neighbourhoods, only: [:index, :show]
end
