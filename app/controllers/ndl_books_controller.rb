class NdlBooksController < ApplicationController
  before_filter :authenticate
  before_filter :check_librarian

  def index
    if params[:page].to_i == 0
      page = 1
    else
      page = params[:page]
    end
    @query = params[:query].to_s.strip
    books = NdlBook.search(params[:query], page)
    @books = Kaminari.paginate_array(
      books[:items], total_count: books[:total_entries], page: page
    ).page(page).per(10)

    respond_to do |format|
      format.html
    end
  end

  def create
    if params[:book]
      begin
        @manifestation = NdlBook.import_from_sru_response(params[:book][:iss_itemno])
      rescue EnjuNdl::RecordNotFound
      end
      respond_to do |format|
        if @manifestation.try(:save)
          format.html { redirect_to @manifestation, notice: t('controller.successfully_created', model: t('activerecord.models.manifestation')) }
        else
          format.html { redirect_to ndl_books_url, notice: t('enju_ndl.record_not_found') }
        end
      end
    end
  #rescue ActiveRecord::RecordInvalid => e
  #  respond_to do |format|
  #    flash[:notice] = e.message
  #    format.html { render action: "index" }
  #  end
  end

  private
  def check_librarian
    unless current_user.try(:has_role?, 'Librarian')
      access_denied
    end
  end
end
