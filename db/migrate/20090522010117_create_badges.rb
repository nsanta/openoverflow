class CreateBadges < ActiveRecord::Migration
  def self.up
    create_table :badges do |t|
      t.string :title
      t.string :level
      t.string :description
      t.string :image_url
      t.string :model
      t.string :command
      t.timestamps
    end
  end

  def self.down
    drop_table :badges
  end
end
