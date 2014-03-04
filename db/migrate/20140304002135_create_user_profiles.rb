class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.references :user, index: true
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.date :born_on
      t.string :address
      t.string :school
      t.string :grade
      t.string :phone
      t.string :parent_name
      t.string :parent_phone

      t.timestamps
    end
  end
end
