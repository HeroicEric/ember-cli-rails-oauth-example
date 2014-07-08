class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :email, null: false

      t.timestamps
    end

    add_index :users, [:uid, :provider], unique: true
    add_index :users, :username
  end
end
