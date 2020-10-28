class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|

      t.string :event_title
      t.text :memo
      t.datetime :start_time
      t.datetime :end_time
      t.integer :workminutes
      t.integer :user_id
    end
  end
end
