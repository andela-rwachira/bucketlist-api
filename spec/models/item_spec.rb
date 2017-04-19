require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to(:bucket) }
  it { should validate_presence_of(:name) }
end
