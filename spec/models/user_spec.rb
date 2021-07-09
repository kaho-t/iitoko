require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  it 'is valid with a name, email, password and password_confirmation' do
    expect(@user).to be_valid
  end

  it 'is invalid without a name' do
    @user.name = nil
    @user.valid?
    expect(@user.errors[:name]).to include('を入力してください')
  end

  it 'is invalid without an email address' do
    @user.email = nil
    @user.valid?
    expect(@user.errors[:email]).to include('を入力してください', 'は不正な値です')
  end

  it 'is invalid with a duplicate email address' do
    FactoryBot.create(:user, email: 'taro@example.com')
    @user.email = 'TARO@EXAMPLE.COM'
    @user.valid?
    expect(@user.errors[:email]).to include('はすでに存在します')
  end

  it 'is invalid with a too long name' do
    @user.name = 'a' * 51
    @user.valid?
    expect(@user.errors[:name]).to include('は50文字以内で入力してください')
  end

  it 'is invalid with a too long email address' do
    @user.email = 'a' * 256
    @user.valid?
    expect(@user.errors[:email]).to include('は255文字以内で入力してください', 'は不正な値です')
  end

  it 'has an email address saved as lower-case' do
    @user.email = 'Foo@ExAMPle.CoM'
    @user.save
    expect(@user.email).to eq 'foo@example.com'
  end

  describe 'validation of addresses' do
    context 'when an email address is valid' do
      it 'is valid' do
        valid_addresses = %w[user@example.com User@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
          @user.email = valid_address
          expect(@user).to be_valid
        end
      end
    end

    context 'when an email address is invalid' do
      it 'is invalid' do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
        invalid_addresses.each do |invalid_address|
          @user.email = invalid_address
          @user.valid?
          expect(@user.errors[:email]).to include('は不正な値です')
        end
      end
    end
  end

  describe 'validation of password' do
    context "when a password isn't present(blank)" do
      it 'is invalid' do
        @user.password = @user.password_confirmation = ' ' * 8
        @user.valid?
        expect(@user.errors[:password]).to include('を入力してください')
      end
    end

    context 'password length' do
      it 'is invalid with a too short password ' do
        @user.password = @user.password_confirmation = 'aA1'
        @user.valid?
        expect(@user.errors[:password]).to include('は半角8~12文字で英大文字・小文字・数字それぞれ１文字以上含む必要があります')
      end
      it 'is invalid with a too long password' do
        @user.password = @user.password_confirmation = 'aA1' * 10
        @user.valid?
        expect(@user.errors[:password]).to include('は半角8~12文字で英大文字・小文字・数字それぞれ１文字以上含む必要があります')
      end
    end

    context 'when a password does not contain at least one uppercase letter, one lowercase letter or a number' do
      it 'is invalid without an uppercase letter' do
        @user.password = @user.password_confirmation = 'a1' * 4
        @user.valid?
        expect(@user.errors[:password]).to include('は半角8~12文字で英大文字・小文字・数字それぞれ１文字以上含む必要があります')
      end
      it 'is invalid without a lowercase letter' do
        @user.password = @user.password_confirmation = 'A1' * 4
        @user.valid?
        expect(@user.errors[:password]).to include('は半角8~12文字で英大文字・小文字・数字それぞれ１文字以上含む必要があります')
      end
      it 'is invalid without a number' do
        @user.password = @user.password_confirmation = 'aA' * 4
        @user.valid?
        expect(@user.errors[:password]).to include('は半角8~12文字で英大文字・小文字・数字それぞれ１文字以上含む必要があります')
      end
    end
  end
end
