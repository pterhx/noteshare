class RenameTypeInNotes < ActiveRecord::Migration
  def change
    change_table :notes do |t|
      t.rename :type, :file_type
    end
  end
end
