class RemoveQuestionMarkFromActiveColumnInVisitorPasses < ActiveRecord::Migration
  def change
    rename_column :visitor_passes, :active?, :active
  end
end
