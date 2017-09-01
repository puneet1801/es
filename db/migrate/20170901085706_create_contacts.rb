class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.text :address
      t.string :city
      t.string :domain
      t.integer :list_id

      t.timestamps
    end
  end
end
