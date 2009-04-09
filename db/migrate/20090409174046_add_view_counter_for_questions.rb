class AddViewCounterForQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions , :total_views , :integer , :default => 0
  end

  def self.down
    remove_column :questions , :total_views
  end
end
