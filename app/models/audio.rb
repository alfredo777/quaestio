class Audio < ActiveRecord::Base
  mount_uploader :audio_file, AudioAndMediaUploader
  belongs_to :cuestionario
end
