class AddPaseToRespuesta < ActiveRecord::Migration
  def change
    add_column :respuesta, :pase, :integer, default: 0
    add_column :respuesta, :respuesta, :integer, default: 0

  end
end
