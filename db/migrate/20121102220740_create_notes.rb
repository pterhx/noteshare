class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title
      t.string :filename
      t.integer :course_id
      t.integer :user_id
      t.integer :rating
      t.string :type
      t.binary :data

      t.timestamps
    end
  end
end
