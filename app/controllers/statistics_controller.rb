class StatisticsController < ApplicationController

	def index
		@total_distance = Run.where(:UserID => current_user[:id]).sum(:distance)
    	@total_time = Run.where(:UserID => current_user[:id]).sum(:duration)
    
    	@last_week_distance = Run.where(:UserID => current_user[:id]).where(datetime: (Time.now.midnight - 7.day)..Time.now.midnight).sum(:distance)
    	@last_week_time = Run.where(:UserID => current_user[:id]).where(datetime: (Time.now.midnight - 7.day)..Time.now.midnight).sum(:duration)
	    
    	@best_speed = Run.where(:UserID => current_user[:id]).order(velocity_average: :desc)
    	@best_pace = Run.where(:UserID => current_user[:id]).order(pace_average: :asc)
    	@best_distance = Run.where(:UserID => current_user[:id]).order(distance: :desc)
    
        @last_dates = []
        last_da = Run.where(:UserID => current_user[:id]).order(datetime: :desc).pluck(:datetime)
        last_da.each do |la|
            @last_dates.push la.strftime('%d.%m.%Y')
        end
        @last_dates.reverse!

        @last_distances10 = []
    	last_di = Run.where(:UserID => current_user[:id]).order(datetime: :desc).limit(10).pluck(:distance)
        last_di.each do |di|
            @last_distances10.push di/1000
        end
        @last_distances10.reverse!
    	@last_speeds10 = Run.where(:UserID => current_user[:id]).order(datetime: :desc).limit(10).pluck(:velocity_average).reverse!
    	@last_paces10 = Run.where(:UserID => current_user[:id]).order(datetime: :desc).limit(10).pluck(:pace_average).reverse!
	end

end
