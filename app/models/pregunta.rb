class Pregunta < ActiveRecord::Base
  belongs_to :cuestionario
  has_many :respuestas, dependent: :destroy
  has_many :base_de_respuestas, as: :contestacion, dependent: :destroy
  has_many :pase_dinamicos
  
  mount_uploader :imagen, ImagenesPreguntasUploader

  accepts_nested_attributes_for :respuestas, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :pase_dinamicos, :reject_if => :all_blank, :allow_destroy => true


end
