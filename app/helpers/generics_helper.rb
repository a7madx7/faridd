module GenericsHelper
  def semantic_will_paginate(collection)
    content_tag(:div, class: 'ui green centered segment') do
      will_paginate collection, renderer: WillPaginateSemanticUi::ActionView::Renderer
    end
  end
end
