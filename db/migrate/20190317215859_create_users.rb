class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.index :id

      t.string :name
      t.string :phone_number

      t.timestamps
    end
  end
end