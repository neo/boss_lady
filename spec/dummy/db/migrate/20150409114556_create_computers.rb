class CreateComputers < ActiveRecord::Migration
  def change
    create_table :computers do |t|
      t.string :model
      t.integer :monitor_size
      t.integer :ram_size
      t.string :processor
      t.boolean :ssd, default: true
      t.string :storage_size, default: '500GB'
      t.string :graphics_card
      t.timestamps
    end
  end
end
