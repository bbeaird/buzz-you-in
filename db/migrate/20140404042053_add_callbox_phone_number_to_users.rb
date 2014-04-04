class AddCallboxPhoneNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :callbox_phone_number, :string
  end
end
