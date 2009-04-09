class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.text :body
      t.references :user
      t.references :question

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
