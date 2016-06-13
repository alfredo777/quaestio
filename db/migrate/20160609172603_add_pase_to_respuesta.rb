class AddPaseToRespuesta < ActiveRecord::Migration
  def change
    add_column :respuesta, :pase, :number, default: 0
    add_column :respuesta, :respuesta, :number, default: 0

  end
end
