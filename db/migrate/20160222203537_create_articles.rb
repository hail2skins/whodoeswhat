class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :name
      t.text :content
      t.references :business, foreign_key: true

      t.timestamps
    end
    add_index :articles, :name
    add_index :articles, :content
  end
end
