class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :body
      t.references :user
      t.references :answer

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
