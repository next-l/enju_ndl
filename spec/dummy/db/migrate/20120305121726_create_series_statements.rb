class CreateSeriesStatements < ActiveRecord::Migration
  def change
    create_table :series_statements do |t|
      t.text :original_title
      t.text :title_transcription
      t.text :numbering
      t.text :title_subseries
      t.text :title_subseries_transcriptiom
      t.text :numbering_subseries
      t.integer :root_manifestation_id
      t.string :series_statement_identifier
      t.text :note
      t.integer :position
      t.boolean :periodical
      t.string :issn

      t.timestamps
    end

    add_index :series_statements, :series_statement_identifier
    add_index :series_statements, :root_manifestation_id
    add_index :series_statements, :issn
  end
end
