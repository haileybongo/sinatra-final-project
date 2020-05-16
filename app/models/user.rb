class User < ActiveRecord::Base
    has_secure_password
    has_many :plants
    validates :email, uniqueness: true
    validates :username, uniqueness: true
end
