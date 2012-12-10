# VisualStats [![Build Status](https://secure.travis-ci.org/bkleinen/VisualStats.png?branch=master)](https://travis-ci.org/bkleinen/VisualStats)

##This is work in progress, no documentation here, just notes.


# created new environment devheroku

This is an development environment that points to the heroku database and can be used to tryout things.

see 
    config/environment/devheroku

to use it: 

    rails console devheroku

    rails server -e devheroku


# added travis-core as a dependency

by copying three gem lines from travis-api.

Now all model classes come from travis-core, it is still possible to extend them with the configuration hack in 
config/initializers/travis.rb

(maybe move them to app/models/travis though?)

now such things are possible: 
    
    Build::ENV_KEYS
    Build.matrix_keys_for(build.config)

e.g.

     builds = Build.limit(100)
     
     ruby_builds = builds.select {|b| !b.config[:language] || b .config[:language] == "ruby"}
 
     build = ruby_builds.first
     build.config[:language]
 
     Build.matrix_keys_for(build.config)
      => [:rvm, :env] 
     
 
     build.matrix.map {|j| j.number}
 
     build.matrix.map {|j| j.number + " "+j.config[:rvm] + " /  " + j.config[:env] }


 Es scheint sehr viele Repositories ohne Build zu geben? (liegt vielleicht an der Testdatenbank)

     reps = Repositories.limit(100)

     reps.reject { |r| r.builds.size == 0}

gibt 8.


Job.where("repository_id = ?",11593).group("result").count.to_json







