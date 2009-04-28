class AddParsedBodyToContent < ActiveRecord::Migration
  def self.up
    add_column :questions , :parsed_body , :text
    add_column :answers , :parsed_body , :text
  end

  def self.down
    remove_column :questions , :parsed_body
    remove_column :answers , :parsed_body
  end
end
