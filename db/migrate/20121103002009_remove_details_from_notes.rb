class RemoveDetailsFromNotes < ActiveRecord::Migration
  def up
    remove_column :notes, :file_type
    remove_column :notes, :data
  end

  def down
    add_column :notes, :data, :string
    add_column :notes, :file_type, :string
  end
end
