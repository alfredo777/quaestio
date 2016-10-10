class CreateAudios < ActiveRecord::Migration
  def change
    create_table :audios do |t|
      t.integer :cuestionario_id
      t.string :idx
      t.string :audio_file

      t.timestamps null: false
    end
  end
end
