class CreateSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :subjects, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.integer :parent_id, index: true
      t.integer :use_term_id, index: true
      t.string :term, index: true
      t.text :term_transcription
      t.integer :subject_type_id, index: true, null: false
      t.text :scope_note
      t.text :note
      t.integer :required_role_id, default: 1, null: false
      t.integer :lock_version, default: 0, null: false
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
