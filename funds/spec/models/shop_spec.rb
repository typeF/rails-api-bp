require 'rails_helper'

RSpec.describe Shop, type: :model do
  # Check Shop has a 1:1 relationship with Item
  it { should have_many(:items).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:created_by) }
end
