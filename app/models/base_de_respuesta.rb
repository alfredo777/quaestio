class BaseDeRespuesta < ActiveRecord::Base
  belongs_to :contestacion, polymorphic: true
end
