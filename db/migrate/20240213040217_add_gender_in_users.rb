class AddGenderInUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :gender, :string, default: 0
  end
end
