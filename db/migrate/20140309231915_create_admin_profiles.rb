class CreateAdminProfiles < ActiveRecord::Migration
  def change
    create_table :admin_profiles do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :phone
      t.references :admin, index: true

      t.timestamps
    end
  end
end
