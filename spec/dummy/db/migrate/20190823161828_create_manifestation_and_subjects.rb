class CreateManifestationAndSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :manifestation_and_subjects do |t|
      t.references :manifestation, foreign_key: true, null: false
      t.references :subject, foreign_key: true, null: false

      t.timestamps
    end
  end
end
