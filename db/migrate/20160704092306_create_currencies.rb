class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.date :date
      t.float :bid
      t.float :ask

      t.timestamps null: false
    end
  end
end
