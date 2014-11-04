class AddUserToRuns < ActiveRecord::Migration
  def change
  	add_column :runs, :UserID, :integer
  end
end
