Rails.application.routes.draw do
  devise_for :users
  
  root 'queue#home'



  delete '/dequeue' => 'queues#dequeue', as: 'dequeue'

end
