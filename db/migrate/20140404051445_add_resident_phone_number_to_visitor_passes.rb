class AddResidentPhoneNumberToVisitorPasses < ActiveRecord::Migration
  def change
    add_column :visitor_passes, :resident_phone_number, :string
  end
end
