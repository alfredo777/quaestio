class Dispositivo < ActiveRecord::Base
  belongs_to :cuestionario
  belongs_to :token_de_descarga
end
