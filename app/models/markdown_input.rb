class MarkdownInput
  include ActiveModel::API

  attr_accessor :body

  def output
    return "" unless body.present?

    Kramdown::Document.new(body, input: 'GFM').to_html
  end
end
