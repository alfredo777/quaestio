class AddValidationByTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :validation_by_token, :string
  end
end
