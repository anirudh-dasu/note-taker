class CreateUserDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :user_devices do |t|
      t.string :provider
      t.string :uid
      t.string :device_id
      t.string :device_type
      t.string :jwt
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
