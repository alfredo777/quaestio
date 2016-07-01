class ApiController < ApplicationController
  layout "opl"
  def vista_para_respuesta
     @cuestionario = params[:id]
  end

  def vista_gracias_respuesta
     @cuestionario = Cuestionario.find(params[:id])
  end
end
