# -*- encoding: utf-8 -*-
module NdlBooksHelper
  def link_to_import(nbn)
    manifestation = Manifestation.where(:nbn => nbn).first
    if manifestation
      link_to '追加', ndl_books_path(:book => {:nbn => nbn}), :method => :post %>
    end
  end
end
