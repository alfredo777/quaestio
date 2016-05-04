class CreateTokenDeDescargas < ActiveRecord::Migration
  def change
    create_table :token_de_descargas do |t|
      t.integer :cuestionario_id
      t.string :token
      t.boolean :uso

      t.timestamps null: false
    end
    add_index :token_de_descargas, :token
  end
end
