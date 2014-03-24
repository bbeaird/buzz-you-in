class CreateVisitorPasses < ActiveRecord::Migration
  def change
    create_table :visitor_passes do |t|
      t.belongs_to :user
      t.string :visitor_phone_number


      t.timestamps
    end
  end
end
