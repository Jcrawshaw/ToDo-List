require 'spec_helper'

describe UsersHelper do
  let(:valid_attributes) {
    {
      first_name: "Jenny",
      last_name: "Crawshaw",
      email: "jennycrawshaw@gmail.com"
    }
  }
  context "validations" do
    let(:user) { User.new(valid_attributes) }

    before do
      User.create(valid_attributes)
    end

    it "requires an email" do
      expect(user).to validate_presence_of(:email)
    end

    it "requires a unique email" do
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires a unique email (case insensitive)" do
      user.email = "JENNYCRAWSHAW@GMAIL.COM"
      expect(user).to validate_uniqueness_of(:email)
    end
  end

  describe "#downcase_email" do
    it "makes the email attribute lower case" do
      user = User.new(valid_attributes.merge(email: "ADMIN@EXAMPLE.COM"))
      user.downcase_email
      expect(user.email).to eq("admin@example.com")
    end

    it "downcases an email before saving" do
      user = User.new(valid_attributes)
      user.email = "ADMIN@EXAMPLE.COM"
      expect(user.save).to be true
      expect(user.email).to eq("admin@example.com")
    end
  end
end
