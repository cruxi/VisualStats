VisualStats::Application.routes.draw do

######## NEW RESTFUL ROUTES

#TRAVIS
  match 'repositories/builds' => 'visualBuilds#index' #shows all builds of all repositories 
  match 'repositories/builds/jobs' => 'visualJobs#index' #shows all jobs of all builds of all repositories 
  match 'repositories/builds/jobs/languages' => 'visualJobs#listLanguages' #shows all languages used in jobs

#USER
  match 'user/:username/repositories' => 'visualRepositories#listReposForUser'  #show all repositories of a user
  match 'user/:username/:repository_name/builds' => 'visualBuilds#listBuildsForRepo'  #show all builds of a repository of a user
  match 'user/:username/:repository_name/:build_number/jobs' => 'visualJobs#listJobsForBuild'  #show all jobs of a build of a repository of a user
  match 'user/:username/repositories/builds/jobs' => 'visualJobs#listJobsForUser' #show all jobs of a user
  match 'user/:username/jobs' => 'visualJobs#listJobsForUser' #SAME AS ABOVE (show all jobs of a user) but another shorter routing

#LANGUAGE
  match 'languages' => 'visualJobs#listLanguages' #shows all languages used in jobs (SAME as above but another route)
  match 'languages/:language/' => 'visualJobs#listJobsForLanguage' #shows all results of a language -> visualization of success and fail 
  match 'languages/:language1/:language2(/:language3)(/:language4)(/:language5)' => 'visualJobs#listJobsForLanguages'  #shows all results of min two language -> visualization of success and fail 

#DIMENSION
  match 'dimensions/:language/:version1/:version2' => 'visualJobs#listJobsForDimension',  
  :constraints => { :version1 => /[^\/]+/ , :version2 => /[^\/]+/ } #shows all results two versions of a language -> visualization of success and fail 

########


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

 
  resources :builds

  resources :events

  resources :broadcasts

  resources :artifacts





 get 'myData' => 'build_compacts#getJobs', :as => :getData
# get 'getJobs' => 'build_compacts#getJobs', :as => :getJobs

  #umbennen --> muesste findBuildsForRepo heissen
  match 'repositories/:repository_id/builds' => 'builds#findRepos', :as => :findRepos

  #umbennen --> muesste findBuildsForRepo heissen
  match 'builds/:build_id/jobs' => 'jobs#listJobsTemp', :as => :listJobsTemp

  #find the commit belonging to a build
  match 'builds/:build_id/commit' => 'commits#showBelongingCommit', :as => :showBelongingCommit


  match '/calendar',    to: 'start#calendar'
  match '/multi',    to: 'start#multi'
  match '/showReal',    to: 'start#showReal'
  match '/multi2',    to: 'start#multi2'



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
