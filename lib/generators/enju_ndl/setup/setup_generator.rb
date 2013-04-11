class EnjuNdl::SetupGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def setup
    inject_into_class 'app/models/manifestation.rb', Manifestation,
      "  enju_ndl_ndl_search\n"
    inject_into_class 'app/models/import_request.rb', ImportRequest,
      "  enju_ndl_ndl_search\n"
  end
end
