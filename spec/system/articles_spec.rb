RSpec.describe 'Articles', js: true, type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:local) { FactoryBot.create(:local) }
  let(:bookmark) { FactoryBot.build(:bookmark, user: user, local: local) }
  let(:article) { FactoryBot.build(:article, local: local) }
  let(:another_article) { FactoryBot.build(:article, title: 'another', local: local) }
  let(:another_local) { FactoryBot.create(:local) }
  before do
    local.confirm
    user.confirm
    bookmark.save
    @number_of_articles = Article.count
    @number_of_tags = Tag.count
  end
  describe 'creating new article' do
    it 'success to create an article' do
      sign_in local
      visit new_article_path

      expect do
        fill_in 'タイトル', with: article.title
        fill_in_rich_text_area '本文', with: article.content
        page.attach_file(Rails.root.join('spec/files/attachment.jpeg').to_s) do
          page.find('.trix-button--icon-attach').click
        end
        check '建築・街並み'
        check 'イベント・祭'
        click_button '投稿'
        expect(Article.count).to eq @number_of_articles + 1
        expect(Tag.count).to eq @number_of_tags + 1
      end.to change(Notification, :count).by(1)
      expect(page).to have_current_path article_path(Article.last)
      expect(page).to have_content article.title
      expect(page).to have_content 'this is my article!'
      expect(page).to have_css 'figure.attachment'
      expect(page).to have_content '建築・街並み'
    end
    context 'fails to create an article' do
      it 'has no title' do
        sign_in local
        visit new_article_path
        fill_in 'タイトル', with: nil
        fill_in_rich_text_area '本文', with: article.content
        click_button '投稿'
        expect(Article.count).to eq @number_of_articles
        expect(page).to have_current_path '/articles'
      end
      # it 'has a too big image' do
      #   sign_in local
      #   visit new_article_path
      #   fill_in 'タイトル', with: article.title
      #   fill_in_rich_text_area '本文', with: article.content
      #   page.attach_file("#{Rails.root}/spec/files/attachment.jpeg") do
      #     page.find('.trix-button--icon-attach').click
      #   end
      #   click_button '投稿'
      #   expect(Article.count).to eq @number_of_articles
      #   expect(page).to have_current_path '/articles'
      # end
    end
  end
  describe 'articles index page' do
    it 'shows locals articles' do
      sign_in local
      article.save
      visit local_path(local)
      execute_script('window.scrollBy(0,10000)')
      within 'div.local_main' do
        click_link "#{local.name}の他の記事をみてみる"
      end
      expect(page).to have_current_path local_articles_path(local)
      expect(page).to have_content article.title
    end
  end
  describe 'editing' do
    it 'edits an article from index page' do
      article.save
      sign_in local
      visit local_articles_path(local)
      find('.fa-edit').click
      expect(page).to have_current_path edit_article_path(article)
      fill_in_rich_text_area '本文', with: '更新しました'
      click_button '更新'
      expect(page).to have_current_path article_path(article)
      expect(page).to have_content '更新しました'
    end
    it 'edits an article from article page' do
      article.save
      sign_in local
      visit article_path(article)
      find('.fa-edit').click
      expect(page).to have_current_path edit_article_path(article)
      fill_in_rich_text_area '本文', with: '更新しました'
      click_button '更新'
      expect(page).to have_current_path article_path(article)
      expect(page).to have_content '更新しました'
    end
    it 'fails to edit an article' do
      article.save
      sign_in local
      visit article_path(article)
      find('.fa-edit').click
      expect(page).to have_current_path edit_article_path(article)
      fill_in 'タイトル', with: ' '
      click_button '更新'
      expect(page).to have_current_path article_path(article)
    end
  end
  describe 'deleting' do
    it 'deletes an article from index page' do
      another_article.save
      article.save
      sign_in local
      visit local_articles_path(local)
      expect do
        accept_alert do
          within "div#article-#{article.id}" do
            find('.fa-trash-alt').click
          end
        end
        expect(page).to have_current_path local_articles_path(local)
        expect(page).to have_no_content article.title
      end.to change(Article, :count).by(-1)
    end
    it 'deletes an article from article page' do
      article.save
      sign_in local
      visit article_path(article)
      expect do
        accept_alert do
          find('.fa-trash-alt').click
        end
        expect(page).to have_current_path local_articles_path(local)
        expect(page).to have_no_content article.title
      end.to change(Article, :count).by(-1)
    end
  end
  describe 'from invalid account' do
    before do
      another_local.confirm
      article.save
    end
    it 'fails to edit' do
      sign_in another_local
      visit edit_article_path(article)
      expect(page).to have_current_path local_path(another_local)
    end
    it 'doesnt show links' do
      sign_in another_local
      visit local_articles_path(local)
      expect(page).to have_no_content '削除'
      expect(page).to have_no_content '編集'
      visit article_path(article)
      expect(page).to have_no_content '削除'
      expect(page).to have_no_content '編集'
    end
  end
end
