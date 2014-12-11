class GpxController < ApplicationController
	def new
    end
    
    def create
        if params[:file]
            if File.extname(params[:file].original_filename) == ".gpx"
                parse_result = parse(params[:file])
                session[:datetime] = parse_result[:datetime]
                session[:distance] = parse_result[:distance]
                session[:duration] = parse_result[:duration]
                session[:velocity_average] = parse_result[:velocity_average]
                session[:pace_average] = parse_result[:pace_average]
                session[:points] = parse_result[:points]
                session[:temperatur] = parse_result[:temperatur]
                session[:wetter] = parse_result[:wetter]
                redirect_to controller: "runs" , action: "new"
                #render html: "<strong>Done!</strong> <a href='/runs'>Show all Runs.</a>".html_safe
            else
                flash[:error] = "Chosen File was no .gpx-file"
                redirect_to controller: "gpx" , action: "new"
            end
        else
            flash[:error] = "No .gpx-file chosen"
            redirect_to controller: "gpx" , action: "new"
        end
    end

    def dateUmsetzung (date)
        date_tag = date[8..9]
        date_monat = date[5..6]
        date_jahr = date[0..3]
        date_uhrzeit = Time.parse(date[11..18])
        #date_ges = {"day" => date_tag, "month" => date_monat, "year" => date_jahr}
        date_ges = Date.parse(date_tag + "." + date_monat + "." + date_jahr)
        return [date_ges, date_uhrzeit]
    end

    def haversine (eins, zwei)
    
        lat1 = eins[0]
        lon1 = eins[1]
        lat2 = zwei[0]
        lon2 = zwei[1]
    
        rad_per_deg = Math::PI/180  # PI / 180
        rkm = 6371                  # Earth radius in kilometers
        rm = rkm * 1000             # Radius in meters

        dlon_rad = (lon2-lon1) * rad_per_deg  # Delta, converted to rad
        dlat_rad = (lat2-lat1) * rad_per_deg

        lat1_rad, lon1_rad = [lat1, lon1].map! {|i| i * rad_per_deg }
        lat2_rad, lon2_rad = [lat2, lon2].map! {|i| i * rad_per_deg }

        a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
        c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

        distance = rm * c # Delta in meters
        return distance
    end

    def calculateDistance (points)
        distance = 0
        points.each_with_index do |point, i|
            if points[i+1]
                distance = distance + haversine(point, points[i+1])
            end
        end
        return distance
    end

    def getAllPoints (trkseg)
        points = Array.new
        trkseg.css("trkpt").each do |trkpt|
            lat1 = trkpt["lat"].to_f
            lon1 = trkpt["lon"].to_f
            points.push [lat1, lon1]
        end
        return points
    end

    def getDauer (trkseg)
        first_time = Time.parse(trkseg.css("trkpt")[0].css("time").text)
        last_time = Time.parse(trkseg.css("trkpt")[-1].css("time").text)
        difference = last_time - first_time
        #in Minuten
        difference = difference / 60
        return difference
    end

    def getGeschDurchschnitt (distance, dauer)
        durchschnitt = (distance / 1000) / (dauer / 60)
        return durchschnitt
    end

    def getPaceDurchschnitt (distance, dauer)
        pace = dauer / (distance / 1000)
        return pace
    end

    def parse (gpx_file)
        #öffne die gpx
        gpx = Nokogiri::XML(open(gpx_file))
        #hole den Dateinamen, das Datum, berechne die Distanz, die Dauer
        #filename = File.basename gpx_file
        datetime = Time.parse(gpx.css("name")[0].text)
        points = getAllPoints(gpx.css("trkseg"))
        distance = calculateDistance(points)
        time_difference = getDauer(gpx.css("trkseg"))
        gesch_durchschnitt = getGeschDurchschnitt(distance, time_difference)
        pace_durchschnitt = getPaceDurchschnitt(distance, time_difference)
        latlong = gpx.css("trkpt")[0]
        
        #hole die historischen Wetterdaten
        weather = Nokogiri::XML(open('http://api.worldweatheronline.com/free/v2/past-weather.ashx?key=1226bb2384684891b6657577b3f19&q=' + latlong["lat"] + ',' + latlong["lon"] + '&date=' + datetime.strftime("%Y-%m-%d")).read)
        
        temperatur = ""
        wetter = ""

        #Irgendwie das korrekte 3-Stunden-Interval herausbekommen.
        weather.css("hourly").each do |hour|
            time = hour.css("time").text
            p time
            p datetime.strftime("%k%I")
            p (datetime.strftime("%k%I").to_f - time.to_f)
            if (datetime.strftime("%k%I").to_f - time.to_f) < 300
                temperatur = hour.css("tempC")[0].text
                p temperatur
                wetter = hour.css("weatherDesc")[0].text
                p wetter
                break
            end
        end
        
#date_umgesetzt[2] + date_umgesetzt[1] + date_umgesetzt[0] - , :time => date_umgesetzt[3]

        #Run.create({:time => time, :distance => distance, :duration => time_difference, :velocity_average => gesch_durchschnitt, :pace_average => pace_durchschnitt, :points => points})
        return {:datetime => datetime, :distance => distance, :duration => time_difference, :velocity_average => gesch_durchschnitt, :pace_average => pace_durchschnitt, :points => points, :temperatur => temperatur, :wetter => wetter}
        
    end
    
    private
      def run_params
        params.require(:run).permit(:name, :attachment)
      end

end
