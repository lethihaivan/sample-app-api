require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe "Test for validation" do
    it {should validate_presence_of(:follower_id)}
    it {should validate_presence_of(:followed_id)}
  end
end
