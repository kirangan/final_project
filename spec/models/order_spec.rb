require 'rails_helper'

describe Order do
  it "has a valid factory" do
    expect(build(:order)).to be_valid
  end

  it "is valid with a mode, origin, destination, and payment" do
    expect(build(:order)).to be_valid
  end

  it "is invalid without a mode" do 
    order = build(:order, mode: nil)
    order.valid?
    expect(order.errors[:mode]).to include("can't be blank")
  end

  it "is invalid with wrong mode" do
    expect{ build(:order, mode: "Go-motor") }.to raise_error(ArgumentError)
  end

  it "is invalid without an origin" do
    order = build(:order, origin: nil)
    order.valid?
    expect(order.errors[:origin]).to include("can't be blank")
  end

  it "is invalid without a destination" do
    order = build(:order, destination: nil)
    order.valid?
    expect(order.errors[:destination]).to include("can't be blank")
  end


end