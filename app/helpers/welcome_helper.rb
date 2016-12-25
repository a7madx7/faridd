module WelcomeHelper
  def stat(model, icon)
    model = model.to_s.capitalize.constantize
    count = model.all.count
    plural = model.first.class.name
    <<HTML
  <div class="statistic">
      <div class="value">
        #{count}
        <i class="#{icon} icon"></i>
      </div>
      <div class="label">
        #{plural.gsub(/y$/, 'ie')}s
      </div>
    </div>
HTML
    .html_safe
  end

  def models
    {
        user: 'users',
        drug: 'trademark',
        generic: 'lab',
        formulation: 'idea',
        category: 'list',
        offer: 'dollar',
        question: 'question mark',
        article: 'edit',
        company: 'suitcase',
        country: 'flag'
    }
  end
end
