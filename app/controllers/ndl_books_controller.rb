class NdlBooksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_librarian

  def index
    if params[:page].to_i == 0
      page = 1
    else
      page = params[:page]
    end
    @query = params[:query].to_s.strip
    books = NdlBook.search(params[:query], page)
    @books = WillPaginate::Collection.create(page, NdlBook.per_page, books[:total_entries]) do |pager|
      pager.replace books[:items]
    end
  end

  def create
    if params[:book]
      @manifestation = NdlBook.import_from_sru_response(params[:book][:nbn])
      if @manifestation
        flash[:notice] = t('controller.successfully_created', :model => t('activerecord.models.manifestation'))
        flash[:porta_import] == true
        redirect_to manifestation_items_url(@manifestation)
      else
        flash[:notice] = t('page.record_not_found')
        redirect_to ndl_books_url
      end
    end
  end

  private
  def check_librarian
    unless current_user.try(:has_role?, 'Librarian')
      access_denied
    end
  end
end
