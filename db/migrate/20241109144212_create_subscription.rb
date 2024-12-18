class CreateSubscription < ActiveRecord::Migration[7.2]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :source, null: false, foreign_key: true

      t.timestamps
    end
  end
end
