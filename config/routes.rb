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
  get '/reviews/:id/edit', to: 'reviews#edit'
  patch '/reviews/:id', to: 'reviews#update'

  patch '/favorites/:id', to: 'favorites#update'
  get '/favorites', to: 'favorites#index'

  get '/pets', to: 'pets#index'
  get '/shelters/:id/pets/new', to: 'pets#new'
  get '/pets/:id', to: 'pets#show'
  post '/shelters/:id/pets', to: 'pets#create'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#delete'
  delete '/shelters/:id/pets/:id', to: 'pets#destroy'
end
