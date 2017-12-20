require 'rails_helper'

describe User do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is valid with a username" do 
    expect(build(:user)).to be_valid
  end

  it "is invalid without a username" do
    user = build(:user, username: nil)
    user.valid?
    expect(user.errors[:username]).to include("can't be blank")
  end

  it "is invalid with duplicate username" do
    user1 = create(:user, username: "hanazawa")
    user2 = build(:user, username: "hanazawa")

    user2.valid?
    expect(user2.errors[:username]).to include("has already been taken")
  end

  it "is invalid without an email" do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid with email not in valid email format" do
    user = build(:user, email: "email")
    user.valid?
    expect(user.errors[:email]).to include("must be in valid email format")
  end


  context "on a new user" do
    it "is invalid without a password" do
      user = build(:user, password: nil, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid with less than 8 characters" do
      user = build(:user, password: "short", password_confirmation: "short")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
    end

    it "is invalid with a confirmation mismatch" do 
      user = build(:user, password: "longpassword", password_confirmation: "longpassword1")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end

  context "on an existing user" do
    before :each do
      @user = create(:user)
    end

    it "is valid with no changes" do
      expect(@user.valid?).to eq(true)
    end

    it "is invalid with an empty password" do
      @user.password_digest = ""
      @user.valid?
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it "is valid with a new (valid) password" do
      @user.password = "newlongpassword"
      @user.password_confirmation = "newlongpassword"
      expect(@user.valid?).to eq(true)
    end
  end

  context "add gopay attributes" do
    before :each do
      @user = create(:user)
    end

    it "is valid with default value 0.0" do
      expect(@user.gopay).to eq(0.0)
    end

    it "is invalid if gopay less than 0.0" do
      user1 = build(:user, gopay: -2)
      user1.valid?
      expect(user1.errors[:gopay]).to include("must be greater than or equal to 0.0")
    end

    it "is invalid gopay non numeric" do
      user = build(:user, gopay:"dollar")
      user.valid?
      expect(user.errors[:gopay]).to include("is not a number")
    end

    # it "reduce gopay after order save" do
    #   user = create(:user, gopay: 100000)
    #   driver = create(:driver, vehicle_type: "Go-Bike", location: "sarinah jakarta")
    #   order = create(:order, mode: "Go-Bike", origin: "sarinah jakarta", destination: "tanah abang",payment: "Go-Pay", user: user)
    #   User.update_gopay_from_order(order)
    #   expect(user.gopay).to eq(50000)
    # end
  

  end
end