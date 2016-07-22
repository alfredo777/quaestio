class AddEmailToTokenDesacarga < ActiveRecord::Migration
  def change
    add_column :token_de_descargas, :email, :string
  end
end
