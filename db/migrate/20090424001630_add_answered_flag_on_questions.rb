class AddAnsweredFlagOnQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions , :answered , :boolean , :default => false
  end

  def self.down
    remove_column :questions , :answered
  end
end
