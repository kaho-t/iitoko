require 'rails_helper'

RSpec.describe Local, type: :model do
  let(:local) { FactoryBot.build(:local) }
  it 'is valid with a name, email, password and password_confirmation' do
    expect(local).to be_valid
  end
  it 'is invalid without name' do
    local.name = nil
    local.valid?
    expect(local.errors[:name]).to include('を入力してください')
  end
  it 'is invalid with too long name' do
    local.name = 'a' * 51
    local.valid?
    expect(local.errors[:name]).to include('は50文字以内で入力してください')
  end
  it 'is invalid without email address' do
    local.email = nil
    local.valid?
    expect(local.errors[:email]).to include('を入力してください')
  end
  it 'is invalid with a duplicate email address' do
    FactoryBot.create(:local, email: 'LOCAL@EXAMPLE.COM')
    local.email = 'local@example.com'
    local.valid?
    expect(local.errors[:email]).to include('はすでに存在します')
  end
  it 'is invalid with a too long email address' do
    local.email = 'a' * 256
    local.valid?
    expect(local.errors[:email]).to include('は255文字以内で入力してください', 'は不正な値です')
  end
  it 'has an email address saved as lower-case' do
    local.email = 'Foo@ExAMPle.CoM'
    local.save
    expect(local.email).to eq 'foo@example.com'
  end

  describe 'validation of addresses' do
    context 'when an email address is valid' do
      it 'is valid' do
        valid_addresses = %w[local3@example.com Local@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
          local.email = valid_address
          expect(local).to be_valid
        end
      end
    end

    context 'when an email address is invalid' do
      it 'is invalid' do
        invalid_addresses = %w[local@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
        invalid_addresses.each do |invalid_address|
          local.email = invalid_address
          local.valid?
          expect(local.errors[:email]).to include('は不正な値です')
        end
      end
    end
  end
  describe 'validation of password' do
    context "when a password isn't present(blank)" do
      it 'is invalid' do
        local.password = local.password_confirmation = ' ' * 8
        local.valid?
        expect(local.errors[:password]).to include('を入力してください')
      end
    end

    context 'password length' do
      it 'is invalid with a too short password ' do
        local.password = local.password_confirmation = 'aA1'
        local.valid?
        expect(local.errors[:password]).to include('は半角8~12文字で英大文字・小文字・数字それぞれ１文字以上含む必要があります')
      end
      it 'is invalid with a too long password' do
        local.password = local.password_confirmation = 'aA1' * 10
        local.valid?
        expect(local.errors[:password]).to include('は半角8~12文字で英大文字・小文字・数字それぞれ１文字以上含む必要があります')
      end
    end

    context 'when a password does not contain at least one uppercase letter, one lowercase letter or a number' do
      it 'is invalid without an uppercase letter' do
        local.password = local.password_confirmation = 'a1' * 4
        local.valid?
        expect(local.errors[:password]).to include('は半角8~12文字で英大文字・小文字・数字それぞれ１文字以上含む必要があります')
      end
      it 'is invalid without a lowercase letter' do
        local.password = local.password_confirmation = 'A1' * 4
        local.valid?
        expect(local.errors[:password]).to include('は半角8~12文字で英大文字・小文字・数字それぞれ１文字以上含む必要があります')
      end
      it 'is invalid without a number' do
        local.password = local.password_confirmation = 'aA' * 4
        local.valid?
        expect(local.errors[:password]).to include('は半角8~12文字で英大文字・小文字・数字それぞれ１文字以上含む必要があります')
      end
    end
  end
end
