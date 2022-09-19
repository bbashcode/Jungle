require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "is valid with valid attributes" do
      user = User.new(first_name: "Jason", last_name: "Stamos", email: "test@test.com", password: "abc123", password_confirmation: "abc123")
      expect(user).to be_valid
    end

    it "is not valid without password" do
      user = User.new(first_name: "Jason", last_name: "Stamos", email: "test@test.com", password: nil, password_confirmation: "abc123")
      expect(user).to_not be_valid
    end

    it "is not valid without password confirmation" do
      user = User.new(first_name: "Jason", last_name: "Stamos", email: "test@test.com", password: "abc123", password_confirmation: nil)
      expect(user).to_not be_valid
    end

    it "is not valid there is no first name" do
      user = User.new(first_name: nil, last_name: "Stamos", email: "test@test.com", password: "abc123", password_confirmation: "abc123")
      expect(user).to_not be_valid
    end

    it "is not valid there is no last name" do
      user = User.new(first_name: "Jason", last_name: nil, email: "test@test.com", password: "abc123", password_confirmation: "abc123")
      expect(user).to_not be_valid
    end

    it "is not valid there is no email" do
      user = User.new(first_name: "Jason", last_name: "Stamos", email: nil, password: "abc123", password_confirmation: "abc123")
      expect(user).to_not be_valid
    end

    it "is not valid if password and its confirmation doesn't match" do
      user = User.new(first_name: "Jason", last_name: "Stamos", email: "test@test.com", password: "abc123", password_confirmation: "bye")
      expect(user).to_not be_valid
    end

    it "is not valid if the email already exists in db even with different cases: not case sensitive" do
      user1 = User.create(first_name: "User1", last_name: "User1", email: "test@test.com", password: "123", password_confirmation: "123")
      user2 = User.new(first_name: "User2", last_name: "User2", email: "TEST@test.com", password: "456", password_confirmation: "456")
      expect(user2).to_not be_valid
    end

    it "is not valid if the password is less than 3 letters" do
      user = User.new(first_name: "User", last_name: "User", email: "test@test.com", password: "1", password_confirmation: "1")
      expect(user).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    it "returns the user if they exist in db" do
      user = User.create(first_name: 'User1', last_name:'User1', email:'test1@test.com', password: 'abc123', password_confirmation: 'abc123')

      loginUser = User.authenticate_with_credentials 'test1@test.com', 'abc123'
      expect(user).to match loginUser
    end

    it "returns nil if the user does not exist" do
      user = User.create(first_name: 'User1', last_name:'User1', email:'test1@test.com', password: 'abc123', password_confirmation: 'abc123')

      loginUser = User.authenticate_with_credentials 'test2@test.com', 'abc123'
      expect(loginUser).to be_nil
    end

    it "should be authenticated even there is a few spaces before and/or after their email address " do
      user = User.create(first_name: 'User1', last_name:'User1', email:'  test1@test.com   ', password: 'abc123', password_confirmation: 'abc123')

      loginUser = User.authenticate_with_credentials '  test1@test.com', 'abc123'
      expect(user).to match loginUser
    end

    it "should be authenticated even the user types in the wrong case for their email " do
      user = User.create(first_name: 'User1', last_name:'User1', email:'  TEST1@test.COM   ', password: 'abc123', password_confirmation: 'abc123')

      loginUser = User.authenticate_with_credentials '  test1@test.com', 'abc123'
      expect(user).to match loginUser
    end

    it "should be authenticated even the user types in the wrong case for their email " do
      user = User.create(first_name: 'User1', last_name:'User1', email:'  TEST1@test.COM   ', password: 'abc123', password_confirmation: 'abc123')

      loginUser = User.authenticate_with_credentials 'TesT1@Test.com', 'abc123'
      expect(user).to match loginUser
    end


  end
end