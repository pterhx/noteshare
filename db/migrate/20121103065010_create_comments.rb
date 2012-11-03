class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.string :text
      t.integer :note_id

      t.timestamps
    end
  end
end
