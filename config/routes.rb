Rails.application.routes.draw do
  devise_for :users
  
  root to: 'application#home'

  post 'aircraft/enqueue' => 'queues#enqueue', as: 'enqueue'

  delete 'aircraft/dequeue' => 'queues#dequeue', as: 'dequeue'

end
