class Plant < ActiveRecord::Base
    belongs_to :user
    has_many :water
end
