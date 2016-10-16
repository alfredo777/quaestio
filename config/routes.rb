Rails.application.routes.draw do  
  
  get 'home/acerca_de', as: :about
  get 'home/contacto', as: :contacto
  get 'home/precios', as: :precios
  get 'home/terminos_y_condiciones'
  get 'home/politicas_de_privacidad'
  get 'home/poliza_de_privacidad'
  get 'home/app_nativas', as: :descargas

  root 'manager#all'
  get 'manager/all', as: :cuestionarios
  get 'manager/view', as: :ver_formulario
  get 'manager/new', as: :nuevo_cuestionario
  get 'manager/create', as: :cuestionario_create
  post 'manager/create'
  get 'manager/json_view_cuestionario', as: :json_view_cuestionario
  post 'manager/json_view_cuestionario'
  get 'manager/xml_view_cuestionario', as: :xml_view_cuestionario
  get 'manager/update', as: :update_cuestionario
  get 'manager/responder', as: :responder_cuestionario
  post 'manager/responder'
  get 'manager/edit', as: :editar_cuestionario
  get 'manager/delete', as: :eliminar_cuesarionario
  post 'manager/delete'
  get "manager/todas_las_respuestas_del_form", as: :todas_las_respuestas_del_form
  get "manager/todas_las_respuestas_n"
  get "manager/estadisticas", as: :estadisticas
  get "manager/pregunta_view", as: :pregunta_view
  get "manager/asign_code", as: :asign_code
  get "manager/code_create"
  post "manager/code_create"
  get "manager/update_p_user", as: :update_code_for_user
  get "manager/update_token", as: :update_token
  post "manager/update_token"
  get "manager/audios", as: :audios
  get "manager/audios_filter_by_fid", as: :audios_filter_by_fid
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
  get 'api/vista_para_respuesta'
  get 'api/vista_gracias_respuesta'
  get 'api/json_view_cuestionario'
  get 'api/advanced_json', as: :advanced_json
  get 'api/create_audios', as: :create_audios
  post 'api/create_audios'
  get 'gracias', to: "api#vista_gracias_respuesta", as: :gracias
  get 'opl/:id', to: "api#vista_para_respuesta", as: :opl
  get 'to_spss/:id', to: "api#spss_tables", as: :to_spss
  get 'normalize_data/cuestionario_normalizado', as: :cuestionario_normalizado


  get 'wiki/acceso_a_la_wiki', as: :acceso_a_la_wiki
  get 'wiki/registro_en_wiki', as: :registro_en_wiki
  get 'wiki/solicitar_codigo_wiki', as: :codigo_wiki
  get 'wiki/find_user_wiki', as: :find_user_wiki
  post 'wiki/find_user_wiki'
  get 'wiki/ver_tutoriales', as: :tutoriales
  get 'wiki/evaluar_conocimiento_app_moobile', as: :evaluate
  get 'wiki/register_user_advanced', as: :create_user_wiki
  post 'wiki/register_user_advanced'
  get 'wiki/android', as: :android
  get 'wiki/curso_mobil', as: :mobil
  get 'wiki/finish_session_wiki', as: :finish_session_wiki
  get 'wiki/datos_user_wiki', as: :datos_user_wiki
  get 'wiki/evaluacion_de_conocimientos', as: :evaluacion_de_conocimientos
  get 'wiki/create_eval', as: :create_eval
  post 'wiki/create_eval'

end
