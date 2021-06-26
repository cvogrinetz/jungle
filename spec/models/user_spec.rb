require 'rails_helper'

RSpec.describe User, type: :model do

  subject { User.new(
    name: "Bitterfunk",
    email: "bf@example.com",
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
  end
end
