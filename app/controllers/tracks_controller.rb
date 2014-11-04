class TracksController < ApplicationController
    def index
        @tracks = Track.all
    end
    
    def show
        @track = Track.find(params[:id])
    end
    
    def new
        @track = Track.new
    end
    
    def create
        Track.create({:name => params[:track][:name], :distance => params[:track][:distance], :points => session[:points], :note => params[:track][:note]})
        session[:points] = ""
        session[:distance] = ""
        redirect_to "/tracks"
    end
    
end

#Neuen Track anlegen:
#new: mit Karte, Punkten, Notiz
#DB: Points, Note, Distanz
#von überall auf new verlinken.