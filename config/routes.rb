Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'
  get '/shelters/:id/pets', to: 'shelters#pets_index'
  get '/shelters/:id/reviews/new', to: 'reviews#new'
  post '/shelters/:id/reviews', to: 'reviews#create'
  get '/shelters/:id/reviews/:id/edit', to: 'reviews#edit'
  patch 'shelters/:id/reviews/:id', to: 'reviews#update'
  delete '/shelters/:id/reviews/:id', to: 'reviews#destroy'

  patch '/favorites/:id', to: 'favorites#update'
  get '/favorites', to: 'favorites#index'

  get '/pets', to: 'pets#index'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  get '/pets/:shelter_id', to: 'pets#show'
  post '/shelters/:shelter_id/pets', to: 'pets#create'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#delete'
  delete '/shelters/:id/pets/:id', to: 'pets#destroy'
end
