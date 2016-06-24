class AddFreeToUser < ActiveRecord::Migration
  def change
    add_column :users, :free, :boolean, default: true
  end
end
