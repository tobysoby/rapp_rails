class AddWeatherToRuns < ActiveRecord::Migration
  def change
  	add_column :runs, :temperatur, :string
  	add_column :runs, :wetter, :string
  end
end
