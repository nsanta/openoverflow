class CreateFavorites < ActiveRecord::Migration
  def self.up
    create_table :favorites do |t|
      t.references :user
      t.references :question

      t.timestamps
    end
  end

  def self.down
    drop_table :favorites
  end
end
