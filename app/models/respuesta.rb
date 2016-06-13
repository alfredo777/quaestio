class Respuesta < ActiveRecord::Base
  belongs_to :pregunta
  has_many :volores_multiples_to_respuesta
  has_many :base_de_respuestas, as: :contestacion, dependent: :destroy

  accepts_nested_attributes_for :volores_multiples_to_respuesta, :reject_if => :all_blank, :allow_destroy => true

end
