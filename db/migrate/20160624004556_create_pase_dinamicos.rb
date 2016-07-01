class CreatePaseDinamicos < ActiveRecord::Migration
  def change
    create_table :pase_dinamicos do |t|
      t.integer :de_a
      t.integer :de_b
      t.integer :pase
      t.integer :pregunta_id

      t.timestamps null: false
    end
  end
end
