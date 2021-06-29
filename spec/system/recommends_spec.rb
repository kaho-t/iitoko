RSpec.describe 'Recommends', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:user_score) { FactoryBot.build(:score, nature: 5,
                                         accessibility: 5,
                                         budget: 5,
                                         job_support: 5,
                                         family_support: 5,
                                         culture: 5,
                                         user: user,
                                         local: nil)}
  let(:local) { FactoryBot.create(:local) }
  let(:local_score) { FactoryBot.build(:score, nature: 5,
                                         accessibility: 5,
                                         budget: 5,
                                         job_support: 5,
                                         family_support: 5,
                                         culture: 5,
                                         user: nil,
                                         local: local)}
  let(:local2) { FactoryBot.create(:local, name: '豊島区') }
  let(:local2_score) { FactoryBot.build(:score, nature: 4,
                                         accessibility: 4,
                                         budget: 4,
                                         job_support: 4,
                                         family_support: 4,
                                         culture: 4,
                                         user: nil,
                                         local: local2)}
  let(:local3) { FactoryBot.create(:local, name: '港区') }
  let(:local3_score) { FactoryBot.build(:score, nature: 1,
                                         accessibility: 1,
                                         budget: 1,
                                         job_support: 1,
                                         family_support: 1,
                                         culture: 1,
                                         user: nil,
                                         local: local3)}


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
    visit top_path

    expect(page).to have_content local.name
    expect(page).to have_content local2.name
    expect(page).to have_no_content local3.name
  end

end