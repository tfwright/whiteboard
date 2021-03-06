Whiteboard::Application.routes.draw do

  devise_for :users

  resources :users, :only => [:edit, :show, :update]

  resources :courses do
    collection do
      post :join
    end
    resources :documents, :announcements, :links
    resources :assignments do
      resources :submissions
      collection do
        put :adjust_weighting
      end
    end
    resources :students do
      collection do
        post :enroll
      end
      member do
        delete :unenroll
      end
    end
    resources :grades
    resources :posts
  end

  resources :professors

  match "feedback" => 'feedback#new', :as => "feedback_form"
  match "feedback/deliver" => 'feedback#deliver', :as => "deliver_feedback"

  root :to => "courses#index"

end