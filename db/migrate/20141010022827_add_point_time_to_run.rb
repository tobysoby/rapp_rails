class AddPointTimeToRun < ActiveRecord::Migration
  def change
  	add_column :runs, :point_time, :string
    add_column :runs, :note, :string
    add_column :runs, :feeling, :string
  end
end
