class Youtube
  def initialize(search_result)
   begin
     # search_result = eval search_result
     @id = search_result['id']
     @title = search_result['snippet']['title']
     @thumbnails = search_result['snippet']['thumbnails']
   rescue
     raise Exception
   end
  end
end