class Plant < ActiveRecord::Base
    belongs_to :user
    has_one :water
end
