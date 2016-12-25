class CreateYoutubeVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :youtube_videos do |t|
      t.integer :animatable_id
      t.string  :animatable_type

      t.string :vid_id
      t.text :thumbnails
      t.string :title

      t.timestamps
    end
  end
end
