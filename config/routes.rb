Rails.application.routes.draw do  
  
  root 'manager#all'
  get 'manager/all', as: :cuestionarios
  get 'manager/view', as: :ver_formulario
  get 'manager/new', as: :nuevo_cuestionario
  get 'manager/create', as: :cuestionario_create
  post 'manager/create'
  get 'manager/json_view_cuestionario', as: :json_view_cuestionario
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
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
  get 'api/vista_para_respuesta'
  get 'api/vista_gracias_respuesta'
  get 'api/json_view_cuestionario'
  get 'api/advanced_json', as: :advanced_json
  get 'gracias', to: "api#vista_gracias_respuesta", as: :gracias
  get 'opl/:id', to: "api#vista_para_respuesta", as: :opl
  get 'to_spss/:id', to: "api#spss_tables", as: :to_spss
  get 'normalize_data/cuestionario_normalizado', as: :cuestionario_normalizado


  get 'wiki/acceso_a_la_wiki', as: :acceso_a_la_wiki
  get 'wiki/registro_en_wiki', as: :registro_en_wiki
  get 'wiki/solicitar_codigo_wiki', as: :codigo_wiki
  get 'wiki/find_user_wiki', as: :find_user_wiki
  get 'wiki/ver_tutoriales', as: :tutoriales
  get 'wiki/evaluar_conocimiento_app_moobile', as: :evaluate

end
