class AddResidentByiPhoneNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :resident_byi_phone_number, :string, default: '6505675874'
  end
end
