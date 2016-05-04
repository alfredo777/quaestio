class AddEmogiToPregunta < ActiveRecord::Migration
  def change
    add_column :pregunta, :emogi, :boolean, default: false
    add_column :pregunta, :coleccion_emogi, :string
  end
end
