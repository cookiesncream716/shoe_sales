class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :shoe, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.float :amount

      t.timestamps null: false
    end
  end
end
