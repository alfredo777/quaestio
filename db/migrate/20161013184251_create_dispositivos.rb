class CreateDispositivos < ActiveRecord::Migration
  def change
    create_table :dispositivos do |t|
      t.string  :id_fabrica
      t.string  :modelo
      t.string  :plataforma
      t.string  :version
      t.string  :manufacturado
      t.string  :serial
      t.integer :cuestionario_id
      t.integer :token_de_descarga_id

      t.timestamps null: false
    end
  end
end
