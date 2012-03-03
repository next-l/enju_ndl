# -*- encoding: utf-8 -*-
module NdlBooksHelper
  def link_to_import(nbn)
    if nbn.blank?
      t('enju_ndl.not_available')
    else
      manifestation = Manifestation.where(:nbn => nbn).first
      unless manifestation
        link_to '追加', ndl_books_path(:book => {:nbn => nbn}), :method => :post
      else
        '登録済み'
      end
    end
  end
end
