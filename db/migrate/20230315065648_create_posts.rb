class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :description
      t.belongs_to :user
      t.text :total_likes

      t.timestamps
    end
  end
end
