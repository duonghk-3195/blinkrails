class ChangeGenderTypeInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :gender, :integer, default: 0
  end
end
