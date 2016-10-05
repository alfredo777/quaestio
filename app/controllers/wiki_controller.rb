class WikiController < ApplicationController
  before_filter :filter_user_wiki, only: [:ver_tutoriales, :evaluar_conocimiento_app_mobile, :android]

  def acceso_a_la_wiki
    render layout: "application"
  end

  def registro_en_wiki
    render layout: "application"
  end

  def register_user_advanced
    @wiki_user = WikiUser.new
    @wiki_user.nombre = params[:nombre]
    @wiki_user.apellidos = params[:apellidos]
    @wiki_user.email = params[:email]
    @wiki_user.telefono = params[:telefono]
    @wiki_user.direccion = params[:direccion]
    @wiki_user.puesto = params[:puesto]
    @wiki_user.identificacion = params[:identificacion]
    @wiki_user.numero_identificacion = params[:numero_identificacion]
    @wiki_user.curp = params[:curp]
    @wiki_user.compania_con_registro = params[:compania_con_registro]
    @wiki_user.codigo_de_aprovacion =  SecureRandom.hex(7)
    @wiki_user.codigo_para_actividad = SecureRandom.hex(7)
    @wiki_user.save
    
    message = "El código para ingreso es <b>#{@wiki_user.codigo_para_actividad}</b> este código debe ser guardado para ingresar al sistema."
    redirect_to codigo_wiki_path(message: message)

  end

  def find_user_wiki
    @wiki_user = WikiUser.find_by_codigo_para_actividad(params[:code])
    
    if !@wiki_user.nil?
      session[:wiki_user] = @wiki_user.id
      redirect_to tutoriales_path
      else
      flash[:notice] = "El usuario no pudo ser encontrado con es código"
      redirect_to :back
    end

  end

  def solicitar_codigo_wiki
    @message = params[:message]
    render layout: "application"
  end

  def ver_tutoriales
    render layout: "wiki"
  end

  def evaluar_conocimiento_app_mobile
    render layout: "wiki"
  end

  def android
  end

  def curso_mobil
  end

  def datos_user_wiki
    @wiki_user = WikiUser.find(session[:wiki_user])
  end

  def finish_session_wiki
    session[:wiki_user] = nil
    redirect_to acceso_a_la_wiki_path
  end

  def filter_user_wiki
    if session[:wiki_user] == nil
      redirect_to acceso_a_la_wiki_path
    end
  end
end
