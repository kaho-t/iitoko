class ChangColumnDefaultToTags < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tags, :local_id, true
    change_column_default :tags, :local_id, ""
    change_column_null :tags, :article_id, true
    change_column_default :tags, :article_id, ""
  end
end
