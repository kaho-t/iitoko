require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'validation' do
    let(:profile) { FactoryBot.build(:profile) }
    it 'has a valid factory' do
      expect(FactoryBot.build(:profile)).to be_valid
    end

    it 'is invalid with too long introduction' do
      profile.introduction = 'a' * 256
      profile.valid?
      expect(profile.errors[:introduction]).to include('は255文字以内で入力してください')
    end

    it 'is invalid with too long catchphrase' do
      profile.catchphrase = 'a' * 51
      profile.valid?
      expect(profile.errors[:catchphrase]).to include('は50文字以内で入力してください')
    end

    it 'is invalid with too big population' do
      profile.population = 5_000_000
      profile.valid?
      expect(profile.errors[:population]).to include('は4999999以下の値にしてください')
    end

    it 'is invalid with invalid temperature' do
      profile.temperature = 100.1
      profile.valid?
      expect(profile.errors[:temperature]).to include('は100.0より小さい値にしてください')
      profile.temperature = -10.5
      expect(profile).to be_valid
    end

    it 'is invalid with invalid moved_in' do
      profile.moved_in = 1_000_000
      profile.valid?
      expect(profile.errors[:moved_in]).to include('は1000000より小さい値にしてください')
    end

    it 'is invalid with invalid waiting_children' do
      profile.waiting_children = 1000
      profile.valid?
      expect(profile.errors[:waiting_children]).to include('は1000より小さい値にしてください')
    end

    it 'is invalid with invalid land_price' do
      profile.land_price = 10_000_000
      profile.valid?
      expect(profile.errors[:land_price]).to include('は10000000より小さい値にしてください')
    end

    it 'is invalid with invalid income' do
      profile.income = 100_000_000
      profile.valid?
      expect(profile.errors[:income]).to include('は100000000より小さい値にしてください')
    end

    it 'is invalid with invalid crime_rate' do
      profile.crime_rate = -1.0
      profile.valid?
      expect(profile.errors[:crime_rate]).to include('は0.0以上の値にしてください')
      profile.crime_rate = 100.1
      profile.valid?
      expect(profile.errors[:crime_rate]).to include('は100.0以下の値にしてください')
    end
  end
end
