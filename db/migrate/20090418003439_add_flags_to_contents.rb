class AddFlagsToContents < ActiveRecord::Migration
  def self.up
    %w(questions answers comments).each  do |table|
      add_column table , :flag , :boolean , :default => false
    end  
  end

  def self.down
    %w(questions answers comments).each do |table|
      remove_column table , :flag
    end
  end
end
