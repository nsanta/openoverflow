class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :title
      t.text :body
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
