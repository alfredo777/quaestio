class CategoriasEnPreguntum < ActiveRecord::Base
  belongs_to :pregunta
  has_many :base_de_respuestas, inverse_of: :categorias_en_preguntum
end
