class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|

      t.string :title
      t.text :memo
      t.datetime :start
      t.datetime :end
      t.string :color
      t.boolean :allday
      t.integer :workminutes
      t.integer :user_id
    end
  end
end
