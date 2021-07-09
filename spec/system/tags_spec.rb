RSpec.describe 'Tags', type: :system do
  let(:local) { FactoryBot.create(:local) }
  let(:another_local) { FactoryBot.create(:local) }
  let(:tag) { FactoryBot.build(:tag, local: local) }
  before do
    local.confirm
    another_local.confirm
    @number_of_tags = Tag.count
  end

  describe 'making a tag' do
    it 'creates tags' do
      sign_in local
      visit new_tag_path
      expect(page).to have_content '関連ワード登録'
      check '海'
      check '山'
      check '川'
      check '田畑'
      check '温泉'
      check '北国'
      check '南国'
      check '都心へ好アクセス'
      check 'スモールタウン'
      check '車移動'
      check '電車移動'
      check '物価が安い'
      check '移住支援'
      check '起業支援'
      check '子育て支援'
      check '転職支援'
      check '公園'
      check '教育'
      check '食'
      check '建築・街並み'
      check '歴史'
      check 'イベント・祭'
      check '観光'
      click_button '登録'
      expect(Tag.count).to eq @number_of_tags + 1
    end
    it 'creats tags with some unchecked box' do
      sign_in local
      visit local_path(local)
      click_link 'タグ付けをして移住希望者に見つけてもらいやすくする'
      check '海'
      check '川'
      check '田畑'
      check '温泉'
      check '北国'
      check '南国'
      check '都心へ好アクセス'
      check 'スモールタウン'
      check '車移動'
      check '電車移動'
      check '物価が安い'
      check '移住支援'
      check '起業支援'
      check '子育て支援'
      check '転職支援'
      check '公園'
      check '教育'
      check '食'
      click_button '登録'
      expect(Tag.count).to eq @number_of_tags + 1
      visit local_path(local)
      expect(page).to have_content '海'
      expect(page).to have_no_content '山'
    end
  end
  describe 'editting a tag' do
    before do
      tag.save
    end
    it 'success to edit' do
      sign_in local
      visit local_path(local)
      expect(page).to have_content '海'
      click_link 'タグ編集'
      uncheck '海'
      click_button '確定'
      expect(page).to have_current_path local_path(local)
    end
    it 'redirects to top when invalid account' do
      sign_in another_local
      visit edit_tag_path(tag)
      expect(page).to have_current_path root_path
    end
  end
end
