class CreateVisitorPasses < ActiveRecord::Migration
  def change
    create_table :visitor_passes do |t|
      t.string :visitor_phone_number
      t.boolean :active, default: false
      t.boolean :used, default: false

      t.timestamps
    end
  end
end
