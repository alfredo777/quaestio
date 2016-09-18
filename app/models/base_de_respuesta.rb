class BaseDeRespuesta < ActiveRecord::Base
  belongs_to :contestacion, polymorphic: true

  belongs_to :categorias_en_preguntum, inverse_of: :base_de_respuestas
end
