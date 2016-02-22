class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.text :description
      t.integer :business_id

      t.timestamps
    end
    add_index :groups, :business_id
  end
end
