class TokenDeDescarga < ActiveRecord::Base
  belongs_to :cuestionario
  has_many :dispositivos
end
