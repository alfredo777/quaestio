class AddCompartirToCuestionario < ActiveRecord::Migration
  def change
    add_column :cuestionarios, :compartir, :boolean, default: true
    add_column :cuestionarios, :paginar, :boolean, default: false
  end
end
