class AddPointTimeToRun < ActiveRecord::Migration
  def change
  	add_column :runs, :point_time, :string
  end
end
