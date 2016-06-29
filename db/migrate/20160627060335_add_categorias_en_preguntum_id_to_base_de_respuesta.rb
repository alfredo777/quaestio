class AddCategoriasEnPreguntumIdToBaseDeRespuesta < ActiveRecord::Migration
  def change
    add_column :base_de_respuesta, :categorias_en_preguntum_id, :integer
  end
end
