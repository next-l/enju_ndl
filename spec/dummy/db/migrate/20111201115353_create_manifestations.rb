class CreateManifestations < ActiveRecord::Migration
  def change
    create_table :manifestations do |t|
      t.text :original_title
      t.text :title_transcription
      t.text :title_alternative
      t.text :title_alternative_transcription
      t.string :pub_date
      t.string :isbn
      t.string :nbn
      t.string :ndc
      t.integer :language_id
      t.integer :price
      t.text :description
      t.string :volume_number_string

      t.timestamps
    end
  end
end
