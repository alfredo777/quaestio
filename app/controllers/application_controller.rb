class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :type_cuestions
  helper_method :type_emogi


  def type_cuestions
    @cuestions = [['Multiple','multiple rxc','mt'], ['Abierta','abierta rxc','ab'],  ['Selección','multiplex rxc','sl'], ['Escala','rango rxc', 'es']]
  end

  def type_emogi
    @emogi = [['Con relieve', '/images_sim/tipo1/' ], ['Sin relieve', '/images_sim/tipo2/' ]]
  end


  protected

  def configure_permitted_parameters
    added_attrs = [:name, :image, :email, :password, :password_confirmation, :remember_me, :current_password]
    devise_parameter_sanitizer.for(:sign_up)        << added_attrs
    devise_parameter_sanitizer.for(:account_update) << added_attrs
  end

end
