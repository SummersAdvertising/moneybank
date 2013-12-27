class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name
      t.string :gender
      t.string :phone
      t.string :email
      t.string :quota
      t.string :status

      t.timestamps
    end
  end
end
