class AddAttachmentToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :attachment, :string
  end
end
