class AddArticleIdToTags < ActiveRecord::Migration[6.1]
  def change
    add_reference :tags, :article, foreign_key: true
  end
end