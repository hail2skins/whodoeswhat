class AddBusinessIdToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :business_id, :integer
    add_index :contacts, :business_id
  end
end
