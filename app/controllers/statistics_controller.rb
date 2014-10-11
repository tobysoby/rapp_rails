class StatisticsController < ApplicationController

	def index
		@total_distance = Run.sum(:distance)
    	@total_time = Run.sum(:duration)
    
    	@last_week_distance = Run.where(time: (Time.now.midnight - 7.day)..Time.now.midnight).sum(:distance)
    	@last_week_time = Run.where(time: (Time.now.midnight - 7.day)..Time.now.midnight).sum(:duration)
	    
    	@best_speed = Run.order(velocity_average: :desc)
    	@best_pace = Run.order(pace_average: :asc)
    	@best_distance = Run.order(distance: :desc)
    
    	@last_distances = Run.order(time: :desc).limit(10).pluck(:distance)
    	@last_speeds = Run.order(time: :desc).limit(10).pluck(:velocity_average)
    	@last_paces = Run.order(time: :desc).limit(10).pluck(:pace_average)
	end

end
