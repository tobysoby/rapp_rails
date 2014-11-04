class ChangePointsFromStringToText2 < ActiveRecord::Migration
  def change
      change_column :runs, :points, :text
  end
end