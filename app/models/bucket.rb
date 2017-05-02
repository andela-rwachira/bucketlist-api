class Bucket < ApplicationRecord
  has_many :items, dependent: :destroy
  belongs_to :user
  validates_presence_of :name
end
