class Form < ApplicationRecord
  has_many :drugs

  validates :name, presence: true, uniqueness: true

  def picture(drug)
    unless drug.image_url
      case name
        when /cap/
          'http://www.clipartkid.com/images/223/clipart-capsule-pNaxhs-clipart.png'
        when /tab/
          'https://cdn3.iconfinder.com/data/icons/medical-7/512/pills_medicine_healthcare_pot_medical_vial-512.png'
        when /amp|vial/
          'http://cdn.shopify.com/s/files/1/0185/5092/products/objects-0077.png?v=1369543997'
        when /susp|syr|emul/
          'https://www.1mg.com/images/blue/large/Syrup.png'
        when /drop/
          'https://s.graphiq.com/sites/default/files/4553/media/images/_2737246.png'
        when /cream|oint|gel/
          'http://cdn.onlinewebfonts.com/svg/download_445056.png'
        when /sup/
          'http://findicons.com/files/icons/459/influenza/256/suppository.png'
        else
          'http://marshallan.org/wp-content/uploads/2015/02/drugs.jpg'
      end
    end
  end
end
