module DrugsHelper
  def ingredients_count(drug)
    number_to_human(drug.generics.count)
  end

  def thumbnail(url)
    begin
      LinkThumbnailer.generate("http:#{url}")
    rescue
      nil
    end
  end
end
