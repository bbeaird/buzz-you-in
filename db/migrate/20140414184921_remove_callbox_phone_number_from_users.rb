class RemoveCallboxPhoneNumberFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :callbox_phone_number
  end
end
