class CreateCuestionarios < ActiveRecord::Migration
  def change
    create_table :cuestionarios do |t|
      t.integer :creado_por_id
      t.string :titulo
      t.text :instrucciones

      t.timestamps null: false
    end
  end
end
