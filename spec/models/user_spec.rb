require 'rails_helper'

RSpec.describe User, type: :model do
  it 'Validate presence of required fields' do
    should validate_presence_of(:email)
    should validate_presence_of(:password)
    should validate_presence_of(:name)
    should validate_presence_of(:id_number)
  end
end
