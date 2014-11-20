class ChangePointsFromStringToText3 < ActiveRecord::Migration
  def change
      change_column :tracks, :points, :text
  end
end