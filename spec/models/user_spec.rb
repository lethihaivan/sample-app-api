require "rails_helper"

RSpec.describe User, type: :model do
  describe "Test for validation" do
    it {should validate_presence_of(:name)}
    it {should validate_length_of(:name).is_at_most(Settings.user.name.max_length)}

    it {should validate_presence_of(:email)}
    it {should validate_length_of(:email).is_at_most(Settings.user.email.max_length)}
    it {should validate_uniqueness_of(:email)}

    it {should validate_length_of(:password).is_at_least(Settings.user.password.min_length)}
    it {should have_secure_password}
  end

  describe "Test for associations" do
    it "has many microposts" do
      is_expected.to have_many(:microposts).dependent :destroy
    end

    it "has many following" do
      is_expected.to have_many(:following).through :active_relationships
    end

    it "has many followers" do
      is_expected.to have_many(:followers).through :passive_relationships
    end

    it "has many passive_relationships" do
      is_expected.to have_many(:passive_relationships).dependent :destroy
    end

    it "has many passive_relationships" do
      is_expected.to have_many(:active_relationships).dependent :destroy
    end
  end
end
