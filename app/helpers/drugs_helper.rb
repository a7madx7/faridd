module DrugsHelper
  def ingredients_count(drug)
    number_to_human(drug.generics.count)
  end
end
