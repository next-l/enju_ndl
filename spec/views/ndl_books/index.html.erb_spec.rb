require "spec_helper.rb"

describe "ndl_books/index" do
  describe "ndl search menu" do
    it "should reflect query params for views", vcr: true do
      params[:query] = "test"
      assign(:query, "test")
      books = NdlBook.search(params[:query])
      assign(:books, Kaminari.paginate_array(books[:items],
                                             total_count: books[:total_entries],
                                             ).page(1).per(10))
      render
      expect(rendered).to include "https://iss.ndl.go.jp/books?any=test"
    end
  end
end

