class AddSubjectHeadingTypeIdToSubject < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :subject_heading_type_id, :integer
  end
end
