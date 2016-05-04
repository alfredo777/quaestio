class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :type_cuestions
  helper_method :type_emogi


  def type_cuestions
    @cuestions = [['Multiple','multiple rxc','mt'], ['Abierta','abierta rxc','ab'],  ['Selección','multiplex rxc','sl'], ['Escala','rango rxc', 'es']]
  end

  def type_emogi
    @emogi = [['Con relieve', '/images_sim/tipo1/' ], ['Sin relieve', '/images_sim/tipo2/' ]]
  end

end
