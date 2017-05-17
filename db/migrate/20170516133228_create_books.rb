class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.text :description
      t.string :cover_image_link
      t.boolean :trading, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :books, [:user_id, :updated_at]
  end
end
