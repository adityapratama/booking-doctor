class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.references :doctor, null: false, foreign_key: true
      t.integer :day
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
  end
end
