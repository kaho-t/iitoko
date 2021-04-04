require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = User.new(
      name: "iitoko taro",
      email: "iitoko@example.com",
      password: "foobarbaz",
      password_confirmation: "foobarbaz"
    )
  end

  it "is valid with a name, email" do
    expect(@user).to be_valid
  end

  it "is invalid without a name" do
    @user.name = nil
    @user.valid?
    expect(@user.errors[:name]).to include("can't be blank")
  end

  it "is invalid without an email address" do
    @user.email = nil
    @user.valid?
    expect(@user.errors[:email]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    User.create(
      name: "tester",
      email: "tester@example.com",
      password: "password",
      password_confirmation: "password"
    )
    @user.email = "TESTER@EXAMPLE.COM"
    @user.valid?
    expect(@user.errors[:email]).to include("has already been taken")
  end

  it "is invalid with a too long name" do
    @user.name = "a" * 51
    @user.valid?
    expect(@user.errors[:name]).to include("is too long (maximum is 50 characters)")
  end

  it "is invalid with a too long email address" do
    @user.email = "a" * 256
    @user.valid?
    expect(@user.errors[:email]).to include("is too long (maximum is 255 characters)")
  end

  it "has an email address saved as lower-case" do
    @user.email = "Foo@ExAMPle.CoM"
    @user.save
    expect(@user.email).to eq "foo@example.com"
  end

  describe "validation of addresses" do

    context "when an email address is valid" do
      it "is valid" do
        valid_addresses = %w[user@example.com User@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
          @user.email = valid_address
          expect(@user).to be_valid
        end
      end
    end

    context "when an email address is invalid" do
      it "is invalid" do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
        invalid_addresses.each do |invalid_address|
          @user.email = invalid_address
          @user.valid?
          expect(@user.errors[:email]).to include("is invalid")
        end
      end
    end

  end

  describe "validation of password" do
    context "when a password isn't present(blank)" do
      it "is invalid" do
        @user.password = @user.password_confirmation = " " * 8
        @user.valid?
        expect(@user.errors[:password]).to include("can't be blank")
      end
    end

    context "when a password is too short" do
      it "is invalid" do
        @user.password = @user.password_confirmation = "a" * 7
        @user.valid?
        expect(@user.errors[:password]).to include("is too short (minimum is 8 characters)")
      end
    end
  end

end
