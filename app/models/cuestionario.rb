class Cuestionario < ActiveRecord::Base
  belongs_to :user
  has_many :preguntas, dependent: :destroy
  has_many :indice_de_creacions, dependent: :destroy

  accepts_nested_attributes_for :preguntas, :reject_if => :all_blank, :allow_destroy => true


end
