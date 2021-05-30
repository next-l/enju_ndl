class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects, comment: '件名' do |t|
      t.references :parent, index: true
      t.integer :use_term_id
      t.string :term, null: false
      t.text :term_transcription
      t.references :subject_type, index: true, null: false
      t.text :scope_note
      t.text :note
      t.references :required_role, index: true, default: 1, null: false
      t.integer :lock_version, default: 0, null: false

      t.timestamps
    end
    add_index :subjects, :term
    add_index :subjects, :use_term_id
  end
end
