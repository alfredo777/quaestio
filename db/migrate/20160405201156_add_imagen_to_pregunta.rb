class AddImagenToPregunta < ActiveRecord::Migration
  def change
    add_column :pregunta, :imagen, :string
    add_column :pregunta, :valor, :string
    add_column :pregunta, :de_a, :integer
    add_column :pregunta, :de_b, :integer
  end
end