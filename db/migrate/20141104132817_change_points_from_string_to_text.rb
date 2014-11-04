class ChangePointsFromStringToText < ActiveRecord::Migration
  def change
      change_column :runs, :points, :text
  end
end
