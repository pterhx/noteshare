class CreateCollabs < ActiveRecord::Migration
  def change
    create_table :collabs do |t|
      t.string :title
      t.string :file
      t.integer :course_id

      t.timestamps
    end
  end
end
