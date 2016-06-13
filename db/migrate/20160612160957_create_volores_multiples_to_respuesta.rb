class CreateVoloresMultiplesToRespuesta < ActiveRecord::Migration
  def change
    create_table :volores_multiples_to_respuesta do |t|
      t.integer :respuesta_id
      t.string :nombre_del_valor
      t.integer :cuantificador_del_valor

      t.timestamps null: false
    end
  end
end
