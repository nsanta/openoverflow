class CreateFlags < ActiveRecord::Migration
  def self.up
    %w(questions answers comments).each do |table|
      remove_column table , :flag
    end
    create_table :flags do |t|
      t.integer :flaggeagle_id
      t.string :flaggeable_type
      t.references :user
      t.text :body

      t.timestamps
    end
  end

  def self.down
    %w(questions answers comments).each  do |table|
      add_column table , :flag , :boolean , :default => 0
    end
    drop_table :flags
  end
end
