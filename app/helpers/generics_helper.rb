module GenericsHelper
  def semantic_will_paginate(collection)
    will_paginate collection, renderer: WillPaginateSemanticUi::ActionView::Renderer
  end
end
