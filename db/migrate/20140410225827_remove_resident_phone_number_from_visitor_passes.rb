class RemoveResidentPhoneNumberFromVisitorPasses < ActiveRecord::Migration
  def change
    remove_column :visitor_passes, :resident_phone_number
  end
end
