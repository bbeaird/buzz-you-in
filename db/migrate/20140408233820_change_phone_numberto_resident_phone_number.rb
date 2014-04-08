class ChangePhoneNumbertoResidentPhoneNumber < ActiveRecord::Migration
  def change
    rename_column :users, :phone_number, :resident_phone_number
  end
end
