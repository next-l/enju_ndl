class Patron < ActiveRecord::Base
  belongs_to :language
  belongs_to :required_role, :class_name => 'Role', :foreign_key => 'required_role_id', :validate => true

  def self.import_patrons(patron_lists)
    list = []
    patron_lists.each do |patron_list|
      patron = Patron.where(:full_name => patron_list[:full_name]).first
      unless patron
        patron = Patron.new(
          :full_name => patron_list[:full_name],
          :full_name_transcription => patron_list[:full_name_transcription],
          :language_id => 1
        )
        patron.required_role = Role.where(:name => 'Guest').first
        patron.save
      end
      list << patron
    end
    list
  end
end
