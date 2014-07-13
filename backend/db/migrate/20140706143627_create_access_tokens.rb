class CreateAccessTokens < ActiveRecord::Migration
  def change
    create_table :access_tokens do |t|
      t.integer :user_id, null: false
      t.string :access_token, null: false
      t.datetime :expires_at, null: false

      t.timestamps
    end

    add_index :access_tokens, :user_id
    add_index :access_tokens, :access_token, unique: true
  end
end
