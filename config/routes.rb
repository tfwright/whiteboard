Whiteboard::Application.routes.draw do
  devise_for :users
  
  resources :users, :only => [:edit, :show, :update]
  
  resources :courses do 
    resources :documents, :announcements, :links
    resources :assignments do
      resources :submissions
    end
    resources :students do
      collection do
        post 'import'
        post 'enroll'
      end
      member do
        delete 'unenroll'
      end
    end
  end
  
  match 'feedback' => 'feedback#new', :as => :feedback_form
  match 'feedback/deliver' => 'feedback#deliver', :as => :deliver_feedback

  root :to => "users#index"

end
