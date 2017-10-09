class AddValueToUserOptions < ActiveRecord::Migration[5.1]
  def change
    add_column :user_options, :value, :string
  end
end
