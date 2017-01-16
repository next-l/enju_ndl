module EnjuNdl
  module EnjuManifestation
    extend ActiveSupport::Concern

    included do
      has_one :jpno_record
    end
  end
end

