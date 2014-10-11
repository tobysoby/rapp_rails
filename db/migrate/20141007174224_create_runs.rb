class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
        t.string :time
        t.float :distance
        t.float :duration
        t.float :velocity_average
        t.float :pace_average
        t.string :points

      t.timestamps
    end
  end
end