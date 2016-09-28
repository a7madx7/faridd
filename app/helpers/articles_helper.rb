module ArticlesHelper
  def comment_for(article)
    form_tag(article_path(article.id), class: 'ui large transparent left icon input') do
        '<i class="ui like icon"></i>'.html_safe
        +
        "<input type='text' placeholder='Add a comment...''>".html_safe
    end
  end
end
