class AddUsedFlagToVisitorPass < ActiveRecord::Migration
  def change
    add_column :visitor_passes, :used, :boolean, default: false
  end
end
