class AddActiveFlagToVisitorPass < ActiveRecord::Migration
  def change
    add_column :visitor_passes, :active?, :boolean, default: false
  end
end
