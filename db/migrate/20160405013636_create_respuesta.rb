class CreateRespuesta < ActiveRecord::Migration
  def change
    create_table :respuesta do |t|
      t.string :titulo
      t.integer :pregunta_id
      t.string :valor
      t.boolean :checkflag

      t.timestamps null: false
    end
  end
end
