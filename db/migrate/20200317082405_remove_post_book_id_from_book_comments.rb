class RemovePostBookIdFromBookComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :book_comments, :post_book_id, :integer
  end
end
