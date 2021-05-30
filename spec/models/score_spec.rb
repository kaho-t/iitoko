require 'rails_helper'

RSpec.describe Score, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:score)).to be_valid
  end

  # it "is invalid without user" do
  #   score = FactoryBot.build(:score, user_id: nil)
  #   score.valid?
  #   expect(score.errors[:user]).to include("を入力してください")
  # end

  it "is invalid without any points" do
    score = FactoryBot.build(:score,
                              nature: nil,
                              accessibility: nil,
                              budget: nil,
                              job_support: nil,
                              family_support: nil,
                              culture: nil)
    score.valid?
    expect(score.errors[:nature]).to include("を入力してください")
    expect(score.errors[:accessibility]).to include("を入力してください")
    expect(score.errors[:budget]).to include("を入力してください")
    expect(score.errors[:job_support]).to include("を入力してください")
    expect(score.errors[:family_support]).to include("を入力してください")
    expect(score.errors[:culture]).to include("を入力してください")
  end

  it "is invalid with too big points" do
    score = FactoryBot.build(:score,
                              nature: 6,
                              accessibility: 100,
                              budget: 7,
                              job_support: 8,
                              family_support: 9,
                              culture: 10)
    score.valid?
    expect(score.errors[:nature]).to include("は5以下の値にしてください")
    expect(score.errors[:accessibility]).to include("は5以下の値にしてください")
    expect(score.errors[:budget]).to include("は5以下の値にしてください")
    expect(score.errors[:job_support]).to include("は5以下の値にしてください")
    expect(score.errors[:family_support]).to include("は5以下の値にしてください")
    expect(score.errors[:culture]).to include("は5以下の値にしてください")
  end

  it "is invalid with decimals" do
    score = FactoryBot.build(:score,
                              nature: 1.5,
                              accessibility: 0.5,
                              budget: 5.1,
                              job_support: 0.1,
                              family_support: 1.1,
                              culture: 1.0)
    score.valid?
    expect(score.errors[:nature]).to include("は整数で入力してください")
    expect(score.errors[:accessibility]).to include("は整数で入力してください")
    expect(score.errors[:budget]).to include("は整数で入力してください")
    expect(score.errors[:job_support]).to include("は整数で入力してください")
    expect(score.errors[:family_support]).to include("は整数で入力してください")
    expect(score.errors[:culture]).to include("は整数で入力してください")
  end

  it "is invalid with negative numbers" do
    score = FactoryBot.build(:score,
                              nature: -1,
                              accessibility: -100,
                              budget: -6,
                              job_support: -3,
                              family_support: -1,
                              culture: -5)
    score.valid?
    expect(score.errors[:nature]).to include("は0以上の値にしてください")
    expect(score.errors[:accessibility]).to include("は0以上の値にしてください")
    expect(score.errors[:budget]).to include("は0以上の値にしてください")
    expect(score.errors[:job_support]).to include("は0以上の値にしてください")
    expect(score.errors[:family_support]).to include("は0以上の値にしてください")
    expect(score.errors[:culture]).to include("は0以上の値にしてください")
  end
end
