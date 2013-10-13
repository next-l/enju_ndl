# -*- encoding: utf-8 -*-
module NdlBooksHelper
  def link_to_import_from_ndl(iss_itemno)
    if iss_itemno.blank?
      t('enju_ndl.not_available')
    else
      identifier_type = IdentifierType.where(:name => 'iss_itemno').first
      if identifier_type
        manifestation = Identifier.where(:body => iss_itemno, :identifier_type_id => identifier_type.id).first.try(:manifestation)
      end
      unless manifestation
        link_to t('enju_ndl.add'), ndl_books_path(:book => {:iss_itemno => iss_itemno}), :method => :post
      else
        link_to t('enju_ndl.already_exists'), manifestation
      end
    end
  end
end
