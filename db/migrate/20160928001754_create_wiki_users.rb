class CreateWikiUsers < ActiveRecord::Migration
  def change
    create_table :wiki_users do |t|
      t.string :nombre
      t.string :apellidos
      t.string :email
      t.string :telefono
      t.text   :direccion
      t.string :puesto
      t.string :identificacion
      t.string :numero_identificacion
      t.string :rol_en_el_preoceso
      t.string :curp
      t.string :compania_con_registro
      t.string :codigo_de_aprovacion
      t.string :codigo_para_actividad
      

      t.timestamps null: false
    end
  end
end
