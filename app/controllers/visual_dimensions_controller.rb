class VisualDimensionsController < ApplicationController

	def getDimensions
		VisualDimension.select(:key).select(:value).group(:key, :value).order("count_all desc").count()
	end


	def compare 
		@dimensions = getDimensions
		distinctDimensions = VisualDimension.select(:key).order("key desc").uniq
		@dimensionKeys = Array.new

		distinctDimensions.each do |dim|
			@dimensionKeys << [dim.key, dim.key]
		end

		respond_to do |format|
			format.html # compare.html.erb
		end
	end


	def listDimensionValues
		key = request.params[:key]
		dimensions = VisualDimension.select(:value).where(key: key).where("value IS NOT NULL").order("count_value desc").group(:value).count()

		dimensionValues = Array.new

		#reg = Regexp.new("^[^- ]")
		reg = Regexp.new('^[^-" ][^"]*$')

		dimensions.each do |dimension|
			if reg.match(dimension[0].gsub("\n",""))
				dimensionValues << dimension[0]
			end
		end

		respond_to do |format|
			format.json { render json: dimensionValues }
		end
	end

	def listDimensions
		@dimensions = getDimensions

		respond_to do |format|
			format.html { render :layout => false} # listDimensions.html.erb
			format.json { render json: @dimensions }
		end
	end

	def listDimensionsOverview
		@distinctDimensions = VisualDimension.select(:key).order("key desc").uniq
		@allDimensions = getDimensions			# [[key, value], count]
		@sums = Hash.new

		@dimensions = Hash.new

		@distinctDimensions.each do |dimension|
			puts dimension.key.to_s
			@dimensions[dimension.key.to_s] = Array.new
			@sums[dimension.key.to_s] = 0
			@allDimensions.each do |dim|		# [[key, value], count]

				if dim[0][0].eql?(dimension.key.to_s)
					@dimensions[dimension.key.to_s] << dim
					@sums[dimension.key.to_s] += dim[1]
				end
			end

		end

		respond_to do |format|
			format.html # listDimensionsOverview.html.erb
			format.json { render json: @dimensions }
		end
	end

	def listJobsForDimension
		@key = request.params[:key]
		@value1 = request.params[:value1]
		@value2 = request.params[:value2]

		ui = request.params[:ui].to_i


		@dimensions = VisualDimension.find_by_sql(" SELECT DISTINCT (job1_id), job1_state, job1_finished_at, Job1_build_id, DIM1_VAL, dim2_val FROM 
										(
										SELECT d1.id AS DIM1_ID, d1.key AS DIM1_KEY, d1.value AS DIM1_VAL, j1.id AS job1_id, j1.finished_at AS job1_finished_at, j1.build_id AS Job1_build_id, j1.result AS job1_state
										FROM visual_dimensions d1
										JOIN visual_jobs j1 ON d1.job_id=j1.id
										WHERE key LIKE '#{@key}'
										AND (value LIKE '#{@value1}'OR VALUE LIKE '#{@value2}')
										) AS job1 
										JOIN
										(
										SELECT d2.id AS DIM2_id, d2.key AS DIM2_key, d2.value AS dim2_val,j2.id AS job2_id, j2.build_id AS job2_build_id, j2.result AS job2_state
										FROM visual_dimensions d2
										JOIN visual_jobs j2 ON d2.job_id=j2.id
										WHERE key LIKE '#{@key}'
										AND (value LIKE '#{@value2}'OR VALUE LIKE '#{@value1}')
										) AS job2
										ON job2.job2_build_id = job1.Job1_build_id AND job2.job2_id != job1.job1_id
										WHERE dim2_val != DIM1_VAL AND job1_finished_at IS NOT NULL
										ORDER BY Job1_build_id" )

		@draw = Array.new
		@draw[0] = Hash.new
		@draw[1] = Hash.new

		@draw[0]['name'] = @value1
		@draw[1]['name'] = @value2

		@draw[0]['x'] = Array.new
		@draw[0]['y'] = Array.new

		@draw[1]['x'] = Array.new
		@draw[1]['y'] = Array.new

		@dimensions.each do |dimension|

			if dimension.dim1_val == @value1
				@draw[0]['x'] << dimension.job1_finished_at
				@draw[0]['y'] << dimension.job1_state
			elsif dimension.dim1_val == @value2
				@draw[1]['x'] << dimension.job1_finished_at
				@draw[1]['y'] << dimension.job1_state
			end
			
		end

		@draw = @draw.to_json

		#@dimensions = VisualDimension.select(:job_id).group(:job_id).where('count_job_id > 1').order("count_job_id desc").count()

		if(ui > 0)
			respond_to do |format|
				format.html { render :layout => false }# listJobsForLanguages.html.erb
			end
		else
			respond_to do |format|
				format.html { render :layout => 'frame' }
			end
		end

	end	


	def getDim
		VisualDimension.select(:key).select(:value).group(:key, :value)
	end

	def listDim
		@dimensions = getDim

		respond_to do |format|
			format.html { render :layout => false} # listDimensions.html.erb
			format.json { render json: @dimensions }
		end
	end

	def getLangForDim
		VisualJob.select("lower(language) AS language").group(:language)
	end

	def listForDim
		languageJobs = getLangForDim 

		@languages = Array.new

		#regexp for checking if language is valid
		#remove all languages that begin with ---
		#maybe you could also ask for languages begin with a letter ^[a-zA-Z]
		reg = Regexp.new("^[^- ]")

		languageJobs.each do |job|

			if reg.match(job.language)
				@languages << job
			end
		end                       

		respond_to do |format|
			format.html { render :layout => false} # listDimensions.html.erb
			format.json { render json: @languages }
		end
	end
	
end
