require 'rails_helper'


RSpec.describe Product, type: :model do

  let (:category) { Category.new(name: "Cars") }

  subject { Product.new(
    name: "Beretta",
    price_cents: "1099",
    quantity: 2,
    category: category
  )}


  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end
    it "is not valid without a price" do
      subject.price_cents = nil
      expect(subject).to_not be_valid
  end
    it "is not valid without a quantity" do
      subject.quantity = nil
      expect(subject).to_not be_valid
    end
    it "is not valid without a category" do
      subject.category = nil
      expect(subject).to_not be_valid
    end
  end
end