# -*- encoding: utf-8 -*-
module NdlBooksHelper
  def link_to_import_from_ndl(nbn)
    if nbn.blank?
      t('enju_ndl.not_available')
    else
      manifestation = Manifestation.where(:nbn => nbn).first
      unless manifestation
        link_to t('enju_ndl.add'), ndl_books_path(:book => {:nbn => nbn}), :method => :post
      else
        link_to t('enju_ndl.already_exists'), manifestation
      end
    end
  end
end
