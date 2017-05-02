require 'rails_helper'

RSpec.describe Bucket, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:items).dependent(:destroy) }
  it { should validate_presence_of(:name) }
end
