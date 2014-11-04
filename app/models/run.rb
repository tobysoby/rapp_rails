class Run < ActiveRecord::Base
	validates :datetime, presence: true, uniqueness: true
    validates :distance, presence: true
  	validates :duration, presence: true
  	validates :velocity_average, presence: true
    validates :pace_average, presence: true
    
	serialize :points, Array
end
