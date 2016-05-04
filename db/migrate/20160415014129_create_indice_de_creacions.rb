class CreateIndiceDeCreacions < ActiveRecord::Migration
  def change
    create_table :indice_de_creacions do |t|
      t.string :idx
      t.boolean :web
      t.string :pass_mobile
      t.string :lat
      t.string :long
      t.integer :cuestionario_id

      t.timestamps null: false
    end
    add_index :indice_de_creacions, :idx
    add_index :indice_de_creacions, :pass_mobile
    add_index :base_de_respuesta, :indice_de_creacion
  end
end
