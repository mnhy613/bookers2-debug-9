class CreateBookComments < ActiveRecord::Migration[5.2]
  def change
    create_table :book_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :post_book_id

      t.timestamps

  end  
  
  def change
      add_column :book_comments, 
      :book_id, :integer
  end
    
  end
end
