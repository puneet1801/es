class CreateListSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :list_subscriptions do |t|
      t.integer :list_id
      t.integer :contact_id
      t.boolean :active
      t.integer :status

      t.timestamps
    end
  end
end
