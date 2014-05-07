class AddUserIdToVisitorPasses < ActiveRecord::Migration
  def change
    add_column :visitor_passes, :user_id, :integer
  end
end
