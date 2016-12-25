class YoutubeVideo < ApplicationRecord
  validates :vid_id, presence: true, uniqueness: true

  belongs_to :animatable, polymorphic: true

  def method_missing(name, *args, &block)
    case name
      when /thumbnail$/
        thumbs = eval thumbnails
        if name =~ /^default/
          thumbs['default']['url']
        elsif name =~ /^high/
          thumbs['high']['url']
        else
          thumbs['medium']['url']
        end
      else

    end
  end
end
