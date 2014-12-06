class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.string :permalink
      t.text :content

      t.timestamps
    end
  end
end
