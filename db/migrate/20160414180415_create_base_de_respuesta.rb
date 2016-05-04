class CreateBaseDeRespuesta < ActiveRecord::Migration
  def change
    create_table :base_de_respuesta do |t|
      t.string :contestacion_type
      t.integer :contestacion_id
      t.text :valor, :limit => 10000
      t.string :indice_de_creacion

      t.timestamps null: false

    end
    add_index :base_de_respuesta, :contestacion_id

  end
end
