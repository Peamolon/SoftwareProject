require 'rails_helper'

RSpec.describe Member, type: :model do
  it 'Validate presence of required fields' do
    should validate_presence_of(:user_id)
    should validate_presence_of(:framework)
  end
end
