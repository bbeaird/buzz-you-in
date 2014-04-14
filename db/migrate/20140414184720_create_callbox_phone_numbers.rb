class CreateCallboxPhoneNumbers < ActiveRecord::Migration
  def change
    create_table :callbox_phone_numbers do |t|
      t.integer :user_id
      t.string :callbox_phone_number

      t.timestamps
    end
  end
end
