class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email

      t.timestamps
    end
    add_index :contacts, :first_name
    add_index :contacts, :last_name
    add_index :contacts, :email
  end
end
