class RunsController < ApplicationController
    def index
        @last_run = Run.where(:UserID => current_user[:id]).order(datetime: :desc)
        @runs = Run.where(:UserID => current_user[:id])
    end

    def show
        @run = Run.find(params[:id])
        @runs = Run.all
    end

    def new
    	@run = Run.new
    end

    def create
    	day = params[:run]["datetime(3i)"]
    	month = params[:run]["datetime(2i)"]
    	year = params[:run]["datetime(1i)"]
    	hour = params[:run]["datetime(4i)"]
    	minute = params[:run]["datetime(5i)"]
    	datetime = Time.parse(day + "." + month + "." + year + " " + hour + ":" + minute)
    	r = Run.create({:datetime => datetime, :distance => params[:run][:distance], :duration => params[:run][:duration], :velocity_average => params[:run][:velocity_average], :pace_average => params[:run][:pace_average], :points => session[:points], :UserID => current_user[:id]})
    	#reset_session
        if r.save
            session[:datetime] = Time.now
            session[:distance] = ""
            session[:duration] = ""
            session[:velocity_average] = ""
            session[:pace_average] = ""
            session[:points] = ""
    	   redirect_to "/runs"
        else
            flash[r.errors.messages] = r.errors.messages
            redirect_to controller: "runs", action: "new"
        end
    end

    def edit
    	@run = Run.find(params[:id])
    end

    def update
    	run = Run.find(params[:id])
		day = params[:run]["datetime(3i)"]
    	month = params[:run]["datetime(2i)"]
    	year = params[:run]["datetime(1i)"]
    	hour = params[:run]["datetime(4i)"]
    	minute = params[:run]["datetime(5i)"]
    	datetime = Time.parse(day + "." + month + "." + year + " " + hour + ":" + minute)
    	Run.update_all({:datetime => datetime, :distance => params[:run][:distance], :duration => params[:run][:duration], :velocity_average => params[:run][:velocity_average], :pace_average => params[:run][:pace_average]})
    	redirect_to controller: "runs", action: "show", id: params[:id]
    end

    def destroy
    	run = Run.find(params[:id])
    	run.destroy
    	redirect_to controller: "runs"
    end
end
