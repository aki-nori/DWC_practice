Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


#   Prefix Verb   URI Pattern                                                                              Controller#Action
#                     books GET    /books(.:format)                                                                         books#index
#                           POST   /books(.:format)                                                                         books#create
#                  new_book GET    /books/new(.:format)                                                                     books#new
#                 edit_book GET    /books/:id/edit(.:format)                                                                books#edit
#                      book GET    /books/:id(.:format)                                                                     books#show
#                           PATCH  /books/:id(.:format)                                                                     books#update
#                           PUT    /books/:id(.:format)                                                                     books#update
#                           DELETE /books/:id(.:format)                                                                     books#destroy
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

  resources :books
  get "/" => "books#top"
end
