Rails.application.routes.draw do
  devise_for :users
  
  root to: 'application#home'



  delete '/dequeue' => 'queues#dequeue', as: 'dequeue'

end
