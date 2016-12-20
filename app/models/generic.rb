class Generic < ApplicationRecord
  has_many :drug_generics
  has_many :drugs, through: :drug_generics
  has_many :likes

  validates :name, presence: true, length: (2..128), uniqueness: true

  # scope :same, same_as(drug)

  scope :popular, -> {
    Generic.order(view_count: :desc)
  }


  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  def to_s(drug_id = nil)
    if drug_id
      "#{name.upcase} #{unit(drug_id)}"
    else
      "#{name.upcase}"
    end
  end

  class << self
    def search(q)
      where('name like :value', value: "%#{q}%")
    end

    def same_as(drug)
      where('generic_id = ?', drug.generics)
    end
  end

  def image
    return 'https://upload.wikimedia.org/wikipedia/commons/2/26/Tetraborate-xtal-3D-balls.png' if wikipedia_image_urls == ""
    begin
      ActiveSupport::JSON.decode(wikipedia_image_urls)[0]
    rescue
      'https://upload.wikimedia.org/wikipedia/commons/2/26/Tetraborate-xtal-3D-balls.png'
    end
  end

  def description
    wikipedia_summary ? wikipedia_summary : 'Faridd can search for a description for this generic, just click!'
  end

  def unit(drug_id)
    if drug_id
      begin
        drug_generic = associated_drug_generic(drug_id)
        concentration = drug_generic.concentration
        raise unless concentration
        unit = Unit.find(DrugGeneric.where(generic_id: self.id).first.unit_id).name
        "#{concentration} #{unit}"
      rescue
        ''
      end
    else
      ''
    end
  end

  def associated_drug_generic(drug_id)
    DrugGeneric.where(generic_id: self.id, drug_id: drug_id).first
  end

  def wikipedia_images
    require 'json'
    if wikipedia_image_urls
      begin
        irrelative_images = %w(Yes_check X_mark Lock-green Commons Padlock Question Check Answer Wikipedia Wikimedia Porn)
        decoded_images = ActiveSupport::JSON.decode(wiki('wikipedia_image_urls'))
        irrelative_images.each do |ir|
          decoded_images.reject! { |a| a[ir] }
        end
        decoded_images
      rescue
      end
    end
  end

  def summary
    wiki('wikipedia_summary')
  end

  def extlinks
    require 'json'

    external_links = wiki('wikipedia_extlinks')
    return nil unless external_links
    ActiveSupport::JSON.decode(external_links)
  end

  def wiki(condition)
    unless self.send("#{condition}")
      require 'wikipedia'

      first_name, second_name = nil
      if name['vit']
        name['vit'] = 'Vitamin'
      end
      if name =~ /\-/
        first_name, _, second_name = name.partition('-')
      end

      set_generic_wiki = Proc.new do |page|
        self.wikipedia_page_url = page.fullurl
        self.wikipedia_image_urls = page.image_urls
        self.wikipedia_links = page.links
        self.wikipedia_extlinks = page.extlinks
        self.wikipedia_summary = page.summary

        self.save
      end

      if first_name
        generic_wiki = Wikipedia.find(first_name)
        generic_wiki = Wikipedia.find(second_name) unless generic_wiki.content
        generic_wiki = Wikipedia.find(name) unless generic_wiki.content
        set_generic_wiki.call(generic_wiki)
      else
        set_generic_wiki.call(Wikipedia.find(name))
      end
    end
    self.send("#{condition}")
  end

  include PublicActivity::Model
  tracked owner: -> (controller, model) { controller&.current_user }
end
