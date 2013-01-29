VisualStats::Application.routes.draw do

######## NEW RESTFUL ROUTES

#NAVIGATION

#routes for user specific views##

  match 'user/repositories',    to: 'visualUsers#repositories'
  match 'user/builds',    to: 'visualUsers#builds'
  match 'user/jobs',    to: 'visualUsers#jobs'


#routes for language specific views##

  match 'languages/overview' => 'visualLanguages#listLanguagesOverview', :as => :languages_overview  #shows all languages used in jobs
  match 'languages/builds',    to: 'visualLanguages#builds'
  match 'languages/compare' => 'visualLanguages#compare'

#routes for dimension specific views##
  match 'dimensions/overview' =>  'visualDimensions#listDimensionsOverview' #shows all dimensions
  match 'dimensions/compare' => 'visualDimensions#compare'

########


#TRAVIS
  match 'travis/about' => 'start#about', :as => :about
  match 'repositories/builds' => 'visualBuilds#index' #shows all builds of all repositories
  match 'repositories/builds/jobs' => 'visualJobs#index' #shows all jobs of all builds of all repositories
  match 'repositories/builds/jobs/languages' => 'visualJobs#listLanguages' #shows all languages used in jobs
  match 'repositories' => 'visualRepositories#index'

#USER
  match 'user/:username/repositories' => 'visualRepositories#listReposForUser'  #show all repositories of a user
  match 'user/:username/:repository_name/builds' => 'visualBuilds#listBuildsForRepo'  #show all builds of a repository of a user

  match 'user/:username/repositories/builds/jobs' => 'visualJobs#listJobsForUser' #show all jobs of a user
  match 'user/:username/:repository_name/:build_number/jobs' => 'visualJobs#listJobsForBuild'  #show all jobs of a build of a repository of a user
  match 'user/:username/builds' => 'visualBuilds#listBuildsForUser' #show all builds of a user
  match 'user/:username/builds/:build_id' => 'visualBuilds#showBuild', :as => :show_build  #shows a specific build for a user

  match 'user/:username/jobs' => 'visualJobs#listJobsForUser' #SAME AS ABOVE (show all jobs of a user) but another shorter routing

  match 'user/:username/repositories/:repository_id' => 'visualRepositories#showRepository', :as => :show_repository  #shows a specific repository for a user
  match 'user/:username/:repository_name' => 'visualRepositories#showRepository'  #same route as above

  match 'user/:username' => 'start#aboutUser', :as => :aboutUser  #show all repositories of a user
  match 'user/' => 'start#userOverview', :as => :overview  #

#LANGUAGE
  match 'languages' => 'visualLanguages#listLanguages'  #shows all languages used in jobs (SAME as above but another route)
  match 'languages/:language/' => 'visualJobs#listJobsForLanguage' #shows all results of a language -> visualization of success and fail
  match 'languages/:language/builds' => 'visualBuilds#listBuildsForLanguage' #shows all builds of a language
  match 'languages/:language1/:language2(/:language3)(/:language4)(/:language5)' => 'visualLanguages#listJobsForLanguages',
  :constraints => { :language1 => /[^\/]+/ , :language2 => /[^\/]+/, :language3 => /[^\/]+/, :language4 => /[^\/]+/, :language5 => /[^\/]+/  } #shows all results of min two language -> visualization of success and fail

#DIMENSION
  match 'dimensions' => 'visualDimensions#listDimensions'
  match 'dimensions/:language/:version1/:version2' => 'visualDimensions#listJobsForDimension',
  :constraints => { :version1 => /[^\/]+/ , :version2 => /[^\/]+/ } #shows all results two versions of a language -> visualization of success and fail

########


#####
#START ROUTES
    match 'start' => 'start#index', :as => :welcomePage

    root :to => 'start#index'

end


# webhook callbacks
  match ':username/:repository/notify' => 'webhooks#notify'
