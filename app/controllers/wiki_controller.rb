class WikiController < ApplicationController
  def acceso_a_la_wiki
    render layout: "application"
  end

  def registro_en_wiki
    render layout: "application"
  end

  def find_user_wiki
    render layout: "application"
  end

  def solicitar_codigo_wiki
    render layout: "application"
  end

  def ver_tutoriales
    render layout: "wiki"
  end

  def evaluar_conocimiento_app_mobile
    render layout: "wiki"
  end
end
