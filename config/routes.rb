Rails.application.routes.draw do
  devise_for :users
  
  root to: 'queues#dashboard'

  get 'aircraft/enqueue/new' => 'queues#new', as: 'new_aircraft'

  post 'aircraft/enqueue' => 'queues#enqueue', as: 'enqueue'

  delete 'aircraft/dequeue' => 'queues#dequeue', as: 'dequeue'

end
