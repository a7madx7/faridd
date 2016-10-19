class SearchController < ApplicationController
  before_action :globalize_search_term, only: [:search]

  def search
    # todo: the problem is with the rendering in this function
   if @mode =~ /drugs/
     @results = Drug.search(@term).order(:name).first(9)

     respond_to do |format|
       format.json { render 'rxes/add_drug', layout: false, content_type: 'application/json'}
     end
   elsif mode =~ /diagnosis/
     @results = Diagnosis.where(name: @term).order(:name).first(9)
   else
     @drug_results = Drug.search(@term).order(:name).first(6)
     @generic_results = Generic.search(@term).order(:name).first(6)
     @user_results = User.search(@term).order(:first_name).first(6)

     respond_to do |format|
       format.json
       format.html
       return
     end
   end
  end

  protected
  def globalize_search_term
    @term = params[:term]
    @mode = params[:mode]
  end
end
