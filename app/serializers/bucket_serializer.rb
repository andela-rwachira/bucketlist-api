class BucketSerializer < ActiveModel::Serializer
  # attributes to be serialized
  attributes :id, :name, :created_at, :updated_at, :user_id
  # model association
  has_many :items
end
