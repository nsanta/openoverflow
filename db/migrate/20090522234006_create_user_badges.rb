class CreateUserBadges < ActiveRecord::Migration
  def self.up
    create_table :user_badges do |t|
      t.references :user
      t.references :badge

      t.timestamps
    end
  end

  def self.down
    drop_table :user_badges
  end
end
