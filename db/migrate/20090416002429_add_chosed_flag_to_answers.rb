class AddChosedFlagToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers , :selected , :boolean , :default => false
  end

  def self.down
    remove_column :answers , :selected
  end
end
