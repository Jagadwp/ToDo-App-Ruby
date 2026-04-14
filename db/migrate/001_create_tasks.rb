class CreateTasks < ActiveRecord::Migration[6.0]
  def self.up
    create_table :tasks do |t|
      t.string :title
      t.boolean :completed
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :tasks
  end
end
