# frozen_string_literal: true

class AddCategoryIdToTasks < ActiveRecord::Migration[6.0]
  def self.up
    add_column :tasks, :category_id, :integer
    add_index  :tasks, :category_id
  end

  def self.down
    remove_index  :tasks, :category_id
    remove_column :tasks, :category_id
  end
end