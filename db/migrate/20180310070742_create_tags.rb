class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :title
      t.string :slug

      t.timestamps
    end

    create_join_table :users, :tags do |t|
      t.references :tag, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end

    create_join_table :notes, :tags do |t|
      t.references :tag, foreign_key: true
      t.references :note, foreign_key: true
      t.timestamps
    end
  end
end
