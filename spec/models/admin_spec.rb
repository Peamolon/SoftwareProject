require 'rails_helper'

RSpec.describe Admin, type: :model do
  it 'Validate presence of required fields' do
    should validate_presence_of(:user_id)
  end
end
