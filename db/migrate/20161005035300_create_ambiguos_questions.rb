class CreateAmbiguosQuestions < ActiveRecord::Migration
  def change
    create_table :ambiguos_questions do |t|
      t.integer :wiki_user_id
      t.boolean :respuesta

      t.timestamps null: false
    end
  end
end
