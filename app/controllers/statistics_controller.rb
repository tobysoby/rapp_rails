class StatisticsController < ApplicationController

	def index
		@total_distance = Run.where(:UserID => current_user[:id]).sum(:distance)
    	@total_time = Run.where(:UserID => current_user[:id]).sum(:duration)
    
    	@last_week_distance = Run.where(:UserID => current_user[:id]).where(datetime: (Time.now.midnight - 7.day)..Time.now.midnight).sum(:distance)
    	@last_week_time = Run.where(:UserID => current_user[:id]).where(datetime: (Time.now.midnight - 7.day)..Time.now.midnight).sum(:duration)
	    
    	@best_speed = Run.where(:UserID => current_user[:id]).order(velocity_average: :desc)
    	@best_pace = Run.where(:UserID => current_user[:id]).order(pace_average: :asc)
    	@best_distance = Run.where(:UserID => current_user[:id]).order(distance: :desc)
    
    	@last_distances = Run.where(:UserID => current_user[:id]).order(datetime: :desc).limit(10).pluck(:distance)
    	@last_speeds = Run.where(:UserID => current_user[:id]).order(datetime: :desc).limit(10).pluck(:velocity_average)
    	@last_paces = Run.where(:UserID => current_user[:id]).order(datetime: :desc).limit(10).pluck(:pace_average)
	end

end
