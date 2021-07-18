RSpec.describe 'Recommends', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:user_score) do
    FactoryBot.build(:score, nature: 5,
                             accessibility: 5,
                             budget: 5,
                             job_support: 5,
                             family_support: 5,
                             culture: 5,
                             user: user,
                             local: nil)
  end
  let(:local) { FactoryBot.create(:local) }
  let(:local_score) do
    FactoryBot.build(:score, nature: 5,
                             accessibility: 5,
                             budget: 5,
                             job_support: 5,
                             family_support: 5,
                             culture: 5,
                             user: nil,
                             local: local)
  end
  let(:local2) { FactoryBot.create(:local, name: '豊島区') }
  let(:local2_score) do
    FactoryBot.build(:score, nature: 4,
                             accessibility: 4,
                             budget: 4,
                             job_support: 4,
                             family_support: 4,
                             culture: 4,
                             user: nil,
                             local: local2)
  end
  let(:local3) { FactoryBot.create(:local, name: '港区') }
  let(:local3_score) do
    FactoryBot.build(:score, nature: 1,
                             accessibility: 1,
                             budget: 1,
                             job_support: 1,
                             family_support: 1,
                             culture: 1,
                             user: nil,
                             local: local3)
  end

  before do
    user.confirm
    local.confirm
    local2.confirm
    local3.confirm
    user_score.save
    local_score.save
    local2_score.save
    local3_score.save
  end

  it 'shows recommended locals' do
    sign_in user
    visit home_path
    within('div.recommends') do
      expect(page).to have_content local.name
      expect(page).to have_content local2.name
      expect(page).to have_no_content local3.name
    end
  end
end
