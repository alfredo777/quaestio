class AddPaseToPregunta < ActiveRecord::Migration
  def change
    add_column :pregunta, :pase, :integer
  end
end
