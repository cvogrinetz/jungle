require 'rails_helper'

RSpec.describe User, type: :model do

  subject { User.new(
    name: "Bitter",
    lastName: "Funk",
    email: "bfa@example.com",
    password: "password",
    password_confirmation: "password",
  )}


  describe "Validations" do 
    it 'is valid with valid attributes'do
      expect(subject).to be_valid
    end
    
    it 'is valid when passwords input matches' do
      expect(subject.password).to eq(subject.password_confirmation)
    end

    it 'is not valid when password input doesnt match' do
      subject.password_confirmation = "false"
      expect(subject.password).to_not eq(subject.password_confirmation)
    end

    it 'it is not valid when email already exists in database' do
      User.create(
        name: 'Wobble',
        lastName: "Hop",
        email: "bfa@example.com",
        password: "password",
        password_confirmation: "password",
      )
      expect(subject).to_not be_valid
    end

    it 'should not be valid when email since it is case sensitive' do
      User.create(
        name: 'WobbleHop',
        lastName: "Hop",
        email: "BFA@EXAMPLE.com",
        password: "password",
        password_confirmation: "password",
      )
      expect(subject).to_not be_valid
    end
    
    it 'is not  valid without valid name' do 
      subject.name = nil
      expect(subject).to_not be_valid
    end
    it 'is not  valid without valid lastName' do 
      subject.lastName = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid without valid email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end
  
    it 'is not valid when password is shorter then 4' do
      subject.password = 'oof'
      subject.password_confirmation = 'oof'
      expect(subject).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    
    it 'should pass if proper with proper email and password' do
      user = User.create(name: "Bitter",
        lastName: "Funk",
        email: "bfa@example.com",
        password: "password",
        password_confirmation: "password",
      )
      session = User.authenticate_with_credentials('bfa@example.com', 'password')
      expect(session).to eq(user)
    end

    it 'should pass even with whitespace around email' do
      user = User.create(name: "Bitter",
        lastName: "Funk",
        email: "bfa@example.com",
        password: "password",
        password_confirmation: "password",
      )
      session = User.authenticate_with_credentials('  bfa@example.com', 'password')
      expect(session).to eq(user)
    end

    it 'should pass if even with case sensitive input' do
      user = User.create(name: "Bitter",
        lastName: "Funk",
        email: "bfa@example.com",
        password: "password",
        password_confirmation: "password",
      )
      session = User.authenticate_with_credentials('BFA@EXAMPLE.com', 'password')
      expect(session).to eq(user)
    end

  end
end
