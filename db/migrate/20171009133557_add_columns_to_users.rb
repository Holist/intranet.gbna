class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :ldap_imported, :boolean
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
