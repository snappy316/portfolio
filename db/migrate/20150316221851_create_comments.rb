class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter_name
      t.string :commenter_url
      t.string :commenter_email
      t.text :content
      t.boolean :approved
      t.belongs_to :article, index: true

      t.timestamps null: false
    end
    add_foreign_key :comments, :articles
  end
end
