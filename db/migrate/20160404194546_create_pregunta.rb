class CreatePregunta < ActiveRecord::Migration
  def change
    create_table :pregunta do |t|
      t.string :titulo
      t.string :tipo
      t.string :descripccion
      t.integer :cuestionario_id

      t.timestamps null: false
    end
  end
end
