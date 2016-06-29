class CreateCategoriasEnPregunta < ActiveRecord::Migration
  def change
    create_table :categorias_en_pregunta do |t|
      t.integer :pregunta_id
      t.string :titulo
      t.integer :valor

      t.timestamps null: false
    end
  end
end
