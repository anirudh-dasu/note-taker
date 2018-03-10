class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :encrypted_password
      t.string :username

      t.timestamps
    end
  end
end
