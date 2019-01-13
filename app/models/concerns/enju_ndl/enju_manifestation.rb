module EnjuNdl
  module EnjuManifestation
    extend ActiveSupport::Concern

    included do
      has_one :jpno_record
      searchable do
        string :jpno do
          jpno_record.try(:body)
        end
      end
    end
  end
end
