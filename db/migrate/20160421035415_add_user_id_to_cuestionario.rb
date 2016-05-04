class AddUserIdToCuestionario < ActiveRecord::Migration
  def change
    add_column :cuestionarios, :user_id, :integer
  end
end
