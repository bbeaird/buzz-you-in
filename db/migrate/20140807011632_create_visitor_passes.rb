class CreateVisitorPasses < ActiveRecord::Migration
  def change
    create_table :visitor_passes do |t|
      t.string :visitor_phone_number
      t.boolean :active
      t.boolean :used
      t.references :user, index: true

      t.timestamps
    end
  end
end
