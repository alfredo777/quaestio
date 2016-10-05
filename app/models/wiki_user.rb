class WikiUser < ActiveRecord::Base
 has_many :ambiguos_questions
 mount_uploader :identificacion, IdentificacionUploader

end
