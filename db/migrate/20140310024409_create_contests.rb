class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :name
      t.datetime :starts_at
      t.datetime :ends_at
      t.text :regulations

      t.timestamps
    end
  end
end
