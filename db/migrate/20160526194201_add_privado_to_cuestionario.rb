class AddPrivadoToCuestionario < ActiveRecord::Migration
  def change
    add_column :cuestionarios, :privado, :boolean
  end
end
