class CreateAircrafts < ActiveRecord::Migration
  def change
    create_table :aircrafts do |t|
      t.string :size
      t.string :kind

      t.timestamps null: false
    end
  end
end
