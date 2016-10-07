class SearchController < ApplicationController
  before_filter :globalize_search_term, only: [:search]

  def search
    @drug_results = Drug.search(@term).order(:name).first(5)
    @generic_results = Generic.search(@term).order(:name).first(5)
    @user_results = User.search(@term).order(:first_name).first(5)

    respond_to do |format|
      format.json { render file: 'layouts/search', content_type: 'application/json' }
      format.html { render 'layouts/search' }
    end
  end

  protected
  def globalize_search_term
    @term = params[:term]
  end
end
