module EnjuNdl
  module EnjuAgent
    extend ActiveSupport::Concern

    included do
      has_one :ndla_record
    end
  end
end

