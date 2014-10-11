class RunsController < ApplicationController
    def index
        @last_run = Run.order(time: :desc)
        @runs = Run.all
    end

    def show
        @run = Run.find(params[:id])
        @runs = Run.all
    end
end
