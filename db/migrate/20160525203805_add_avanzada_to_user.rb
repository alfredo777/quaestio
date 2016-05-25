class AddAvanzadaToUser < ActiveRecord::Migration
  def change
    add_column :users, :avanzada, :boolean, default: false
  end
end
