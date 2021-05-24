require 'rails_helper'

RSpec.describe Micropost, type: :model do
  describe "Test for validation" do
    it {should validate_presence_of(:user_id)}
  end
end
