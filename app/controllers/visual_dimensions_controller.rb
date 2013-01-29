class VisualDimensionsController < ApplicationController

	def getDimensions
		VisualDimension.select(:key).select(:value).group(:key, :value).order("count_all desc").count()
	end


	def compare 
		@dimensions = getDimensions

		respond_to do |format|
			format.html # compare.html.erb
			format.json { render json: @languages }
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
		@language = request.params[:language]
		@version1 = request.params[:version1]
		@version2 = request.params[:version2]


		@dimensions = VisualDimension.select(:job_id).joins(:job).where(key: @language).where("visual_dimensions.value='#{@version1}' OR visual_dimensions.value='#{@version2}'").group(:job_id).count()
		@dimensions = VisualDimension.select(:job_id).group(:job_id).where('count_job_id > 1').order("count_job_id desc").count()

		respond_to do |format|
			format.html # listJobsForDimension.html.erb
			format.json { render json: @dimensions }
		end

	end	
	
end
