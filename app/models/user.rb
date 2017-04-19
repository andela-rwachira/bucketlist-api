class User < ApplicationRecord
    has_many :buckets, dependent: :destroy
    validates_presence_of :username, :password
end
