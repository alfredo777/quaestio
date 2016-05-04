class Respuesta < ActiveRecord::Base
  belongs_to :pregunta
  has_many :base_de_respuestas, as: :contestacion, dependent: :destroy
end
