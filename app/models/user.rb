class User < ApplicationRecord
    # password encryption method
    has_secure_password

    has_many :buckets, dependent: :destroy
    validates_presence_of :username, :password_digest
end
