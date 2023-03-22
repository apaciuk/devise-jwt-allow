class CreateAllowlistedJwts < ActiveRecord::Migration[6.1]
  def up
    create_table :allowlisted_jwts, id: :uuid do |t|
      t.references :user, foreign_key: { on_delete: :cascade }, null: false, type: :uuid
      t.string :jti, null: false
      t.string :aud, null: false
      t.datetime :exp, null: false
      t.string :remote_ip
      t.string :os_data
      t.string :browser_data
      t.string :device_data
      t.timestamps null: false
    end

    add_index :allowlisted_jwts, :jti, unique: true
  end 

  def down
    drop_table :allowlisted_jwts
  end
  
end
