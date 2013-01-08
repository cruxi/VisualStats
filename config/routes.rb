VisualStats::Application.routes.draw do
    
  resources :repository_compacts do
      resources :build_compacts do
          resources :job_compacts
      end
  end

  resources :build_compacts 
  resources :job_compacts
  
  resources :jobs

  resources :repositories do
    resources :events
  end

  resources :commits do
    resources :builds
  end

  #get 'data' => 'builds#getData', :as => :getData
  get 'getJobs' => 'build_compacts#getJobs', :as => :getJobs

  resources :builds

  resources :events

  resources :broadcasts

  resources :artifacts

  # umbennen --> muesste findBuildsForRepo heissen
  match 'repositories/:repository_id/builds' => 'builds#findRepos', :as => :findRepos 

  # umbennen --> muesste findBuildsForRepo heissen
  match 'builds/:build_id/jobs' => 'jobs#listJobs', :as => :listJobs 

  # find the commit belonging to a build
  match 'builds/:commit_id/commits' => 'commits#showBelongingCommit', :as => :showBelongingCommit 


  match '/calendar',    to: 'start#calendar'
  match '/multi',    to: 'start#multi'
<<<<<<< HEAD
  match '/showReal',    to: 'start#showReal'
=======
  match '/multi2',    to: 'start#multi2'

>>>>>>> c4da5e4c6b2512f27ce5fd7dafa1f93122a10985

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

    match 'start' => 'start#index', :as => :welcomePage 

    root :to => 'start#index'

end
