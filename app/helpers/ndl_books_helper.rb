# -*- encoding: utf-8 -*-
module NdlBooksHelper
  def link_to_import_from_ndl(jpno)
    if jpno.blank?
      t('enju_ndl.not_available')
    else
      identifier_type = IdentifierType.where(:name => 'jpno').first
      if identifier_type
        manifestation = Identifier.where(:body => jpno, :identifier_type_id => identifier_type.id).first.try(:manifestation)
      end
      unless manifestation
        link_to t('enju_ndl.add'), ndl_books_path(:book => {:jpno => jpno}), :method => :post
      else
        link_to t('enju_ndl.already_exists'), manifestation
      end
    end
  end
end
