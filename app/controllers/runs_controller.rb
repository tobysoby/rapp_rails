class RunsController < ApplicationController
    def index
        @last_run = Run.order(time: :desc)
        @runs = Run.all
    end

    def show
        @run = Run.find(params[:id])
        @runs = Run.all
    end

    def new
    	@run = Run.new
    end

    def create
    	Run.create({:time => params[:run][:time], :distance => params[:run][:distance], :duration => params[:run][:duration], :velocity_average => params[:run][:velocity_average], :pace_average => params[:run][:pace_average], :points => session[:points]})
    	reset_session
    	redirect_to controller: "runs"
    end

    def edit
    	@run = Run.find(params[:id])
    end

    def update
    	run = Run.find(params[:id])
    	run.update({:time => params[:run][:time], :distance => params[:run][:distance], :duration => params[:run][:duration], :velocity_average => params[:run][:velocity_average], :pace_average => params[:run][:pace_average]})
    	redirect_to controller: "runs", action: "show", id: params[:id]
    end

    def destroy
    	run = Run.find(params[:id])
    	run.destroy
    	redirect_to controller: "runs"
    end
end
