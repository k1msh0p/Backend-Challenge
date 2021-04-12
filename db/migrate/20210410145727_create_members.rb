class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :name
      t.string :website
      t.string :url_short
      t.string :heading1
      t.string :heading2
      t.string :heading3

      t.timestamps
    end
  end
end
