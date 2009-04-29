class AddBannedFlagToContents < ActiveRecord::Migration
  def self.up
    %w(questions answers comments users).each do |content|
      add_column content , :banned , :boolean , :default => false
    end
  end

  def self.down
    %w(questions answers comments users).each do |content|
      remove_column content , :banned
    end
  end
end
