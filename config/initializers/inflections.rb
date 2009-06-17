module ActiveSupport
  module Inflector
    extend self

    def slugify(words)
      slug = words.gsub(/[Ää]/, 'ae').
                   gsub(/[Öö]/, 'oe').
                   gsub(/[Üü]/, 'ue').
                   gsub(/&/, 'and').
                   gsub(/[^\w_-]+/i, '-').
                   gsub(/\-{2,}/i, '-').
                   gsub(/^\-|\-$/i, '')
      url_encode(slug.downcase)
    end

    def url_encode(word)
      URI.escape(word, /[^\w_+-]/i)
    end
  end
end

module ActiveSupport::CoreExtensions::String::Inflections
  def slugify
    ActiveSupport::Inflector.slugify(self)
  end

  def url_encode
    ActiveSupport::Inflector.url_encode(self)
  end
end
