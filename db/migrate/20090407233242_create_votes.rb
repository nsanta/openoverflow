class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :vote
      t.string :voteable_type
      t.integer :voteable_id
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
