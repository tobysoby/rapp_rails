class Track < ActiveRecord::Base
    serialize :points, Array
end
