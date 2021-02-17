class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :type_cuestions
  helper_method :type_emogi
  helper_method :agent
  helper_method :year_act

  def year_act
    date = Date.today
    year  = date.strftime('%Y')
    return year
  end


  def type_cuestions
    @cuestions = [['Multiple','multiple rxc','mt'], ['Abierta','abierta rxc','ab'],  ['Selección','multiplex rxc','sl'], ['Escala','rango rxc', 'es']]
  end

  def type_emogi
    @emogi = [['Con relieve', '/images_sim/tipo1/' ], ['Sin relieve', '/images_sim/tipo2/' ]]
  end

  def current_path
  end
  

  def agent
    result  = request.env['HTTP_USER_AGENT']
    puts result
      if result =~ /iPhone|Android|iPad/
        @browser = "Mobile"
        @mobile = true
      else
      case 
      when result =~ /Chrome/
        @browser = "Google Chrome"
        @mobile = false
      when result =~ /Firefox/
        @browser = "Firefox"
        @mobile = false
      when result =~ /Safari/
        @browser = "Safari"
        @mobile = false
      when result =~ /MSIE/
        @browser = "Internet Explorer"
        @mobile = false        
      end 
      end
    puts "********************** #{@browser} / Mobile: #{@mobile} ************************" 
       @mobile
  end
  protected

  def configure_permitted_parameters
    #if Rails.env.production?
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :image, :email, :password, :password_confirmation, :remember_me, :current_password, :validation_by_token)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :image, :email, :password, :password_confirmation, :remember_me, :current_password, :validation_by_token)}
    #else
    #devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :image, :email, :password, :password_confirmation, :remember_me, :current_password, :validation_by_token)}
    #devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :image, :email, :password, :password_confirmation, :remember_me, :current_password, :validation_by_token)}
    #end
  end

end
