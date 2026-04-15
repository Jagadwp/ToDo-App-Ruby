# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[6.0]
  def self.up
    create_table :categories do |t|
      t.string :name, null: false
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :categories
  end
end