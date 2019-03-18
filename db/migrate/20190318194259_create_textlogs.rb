class CreateTextlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :textlogs do |t|
      t.string :name
      t.string :phone
      t.string :message

      t.timestamps
    end
  end
end
