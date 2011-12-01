class CreateManifestations < ActiveRecord::Migration
  def change
    create_table :manifestations do |t|
      t.text :original_title
      t.text :title_transcription
      t.text :title_alternative
      t.string :pub_date
      t.string :isbn
      t.string :nbn
      t.string :ndc
      t.integer :language_id

      t.timestamps
    end
  end
end
