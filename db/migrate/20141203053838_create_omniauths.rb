class CreateOmniauths < ActiveRecord::Migration
  def change
    create_table :omniauths do |t|
      t.belongs_to :user, index: true
      t.string :provider
      t.string :uid
      t.string :image
      t.string :url
    end
  end
end
