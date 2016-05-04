class IndiceDeCreacion < ActiveRecord::Base
  belongs_to :custionario

  def todas_las_respuestas
    @respuestas = BaseDeRespuesta.where(indice_de_creacion: self.idx)
  end
end
