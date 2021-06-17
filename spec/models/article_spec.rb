require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { FactoryBot.create(:article, local: local) }
  let(:local) { FactoryBot.create(:local) }
  let(:recent_article) { FactoryBot.create(:article, local: local)}
  before do
    local.confirm
  end
  it 'orders most recent first' do
    expect(recent_article).to eq Article.first
  end
  describe 'validation' do
    context 'title' do
      it "is invalid without title" do
        article.title = nil
        article.valid?
        expect(article.errors[:title]).to include("を入力してください")
      end
      it "is invalid with too long title" do
        article.title = "a" * 256
        article.valid?
        expect(article.errors[:title]).to include("は255文字以内で入力してください")
      end
      it "is invalid with invalid title" do
        article.title = " " * 10
        article.valid?
        expect(article.errors[:title]).to include("を入力してください")
      end
    end
    context 'content' do
      it 'is invalid without content' do
        article.content = nil
        article.valid?
        expect(article.errors[:content]).to include("を入力してください")
      end
    end
  end
end
