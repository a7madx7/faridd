class SearchController < ApplicationController
  before_action :globalize_search_term, only: [:search]

  def search
    # todo: the problem is with the rendering in this function
   if @mode =~ /drugs/
     @results = Drug.search(@term).order(:name).first(9)

     respond_to do |format|
       format.json { render 'rxes/add_drug', layout: false, content_type: 'application/json'}
     end
   elsif @mode =~ /^diagnosis/
     @results = Diagnosis.search(@term).order(:name).first(9)
   elsif @mode =~ /^generics/
     @results = Generic.search(@term).order(:name).first(9)
   elsif @mode =~ /^category/
     @results = Category.search(@term).order(:name).first(9)
     respond_to do |format|
       format.json { render 'search/add_model', layout: false, content_type: 'application/json'}
     end
   elsif @mode =~ /^unit/
     @results = Unit.search(@term).order(:name).first(9)

     respond_to do |format|
       format.json { render 'search/add_model', layout: false, content_type: 'application/json'}
     end
   elsif @mode =~ /company/
     @results = Company.search(@term).order(:name).first(9)

     respond_to do |format|
       format.json { render 'search/add_model', layout: false, content_type: 'application/json'}
     end
   else # if global search is triggered
     @drug_results = Drug.search(@term).order(:name).limit(6)
     @generic_results = Generic.search(@term).order(:name).limit(6)
     @user_results = User.search(@term).order(:first_name).limit(6)

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
