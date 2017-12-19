require 'rails_helper'

describe Driver do
  it "has a valid factory" do
    expect(build(:driver)).to be_valid
  end

  it "is valid with a username" do 
    expect(build(:driver)).to be_valid
  end

  it "is invalid without a username" do
    driver = build(:driver, username: nil)
    driver.valid?
    expect(driver.errors[:username]).to include("can't be blank")
  end

  it "is invalid with duplicate username" do
    driver1 = create(:driver, username: "hanazawa")
    driver2 = build(:driver, username: "hanazawa")

    driver2.valid?
    expect(driver2.errors[:username]).to include("has already been taken")
  end

  context "on a new driver" do
    it "is invalid without a password" do
      driver = build(:user, password: nil, password_confirmation: nil)
      driver.valid?
      expect(driver.errors[:password]).to include("can't be blank")
    end

    it "is invalid with less than 8 characters" do
      driver = build(:user, password: "short", password_confirmation: "short")
      driver.valid?
      expect(driver.errors[:password]).to include("is too short (minimum is 8 characters)")
    end

    it "is invalid with a confirmation mismatch" do 
      driver = build(:user, password: "longpassword", password_confirmation: "longpassword1")
      driver.valid?
      expect(driver.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end

  context "on an existing driver" do
    before :each do
      @driver = create(:driver)
    end

    it "is valid with no changes" do
      expect(@driver.valid?).to eq(true)
    end

    it "is invalid with an empty password" do
      @driver.password_digest = ""
      @driver.valid?
      expect(@driver.errors[:password]).to include("can't be blank")
    end

    it "is valid with a new (valid) password" do
      @driver.password = "newlongpassword"
      @driver.password_confirmation = "newlongpassword"
      expect(@driver.valid?).to eq(true)
    end
  end

  
end