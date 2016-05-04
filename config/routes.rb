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
  devise_for :users
end
