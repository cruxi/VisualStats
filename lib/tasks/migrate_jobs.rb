step = 10
offset = 0
going = true
result = []

class VJob
	attr_accessor :job_id, :language, :config, :result, :repository_id
	def initialize
		@config = {}
	end
end
class Dimension
	attr_accessor :vjob_id, :key, :value
end


maxdimensions = 0
jobs_with_many_dimensions = []
while going 
  #reps = Repository.limit(step).offset(offset)
  builds = Build.limit(step).offset(offset)
  offset +=step
  going = builds.size > 0
  going = offset < 300

  #reps.each do | repository |
  	#builds = repository.builds
    if builds.size > 0
    	#result << repository.id
    	builds.each do | build |
    		jobs = build.matrix
    		dimensions = Build.matrix_keys_for(build.config)
    		jobs.each do | job |
    			j =  VJob.new
    			j.repository_id = build.repository_id
    			j.job_id = job.id
    			j.language = job.config[:language] || "ruby"
    			j.result = job.result
    			maxdimensions = dimensions.size if dimensions.size > maxdimensions
    			dimensions.each do | dim |
    				j.config[dim] = job.config[dim]
    			end
    			result << j
    		end
    		
    	end
    #end
  end
end


puts "result: "
pp result
$RESULT = result
puts "maxdimensions: #{maxdimensions}"
puts "jobs_with_many_dimensions: #{jobs_with_many_dimensions}"
