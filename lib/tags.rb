module Tags
  class TagError < StandardError; end

  class << self
    def init
      Radius::Context.new do |context|

        context.define_tag 'asset' do |tag|
          prepare(tag)
          check_for_required_attrs(tag, [:id, :title])
          id, title = tag.attr.delete(:id), tag.attr.delete(:title)
          if id
            asset = Asset.find_by_id(id)
            raise TagError.new("Asset with id '#{id}' not found.") if asset.nil?
          else
            assets = Asset.find_all_by_title(title)
            if assets.empty?
              raise TagError.new("Asset with title '#{title}' not found.")
            elsif assets.length > 1
              raise TagError.new("Asset title '#{title}' is ambiguous. Use the id attribute instead.")
            end
            asset = assets.first
          end
          tag.locals.asset = asset
          tag.expand
        end

        context.define_tag 'asset:image' do |tag|
          prepare(tag)
          asset = tag.locals.asset
          size = tag.attr.delete(:size) || 'original'
          if asset.asset_file.content_type !~ /^image/
            %(Cannot show image for asset '#{id}' which has the content type '#{asset.asset_file.content_type}'.)
          elsif !(AppConfig.image_sizes.keys.push('original')).include?(size)
            %('#{size}' is not a valid size for asset '#{asset.id}'.)
          else
            tag.attr[:src] = asset.asset_file.url(size)
            tag.attr[:alt] = tag.double? ? tag.expand : asset.title
            %(<img #{tag_attrs_as_xml_attrs(tag)}>)
          end
        end

        context.define_tag 'asset:link' do |tag|
          prepare(tag)
          asset = tag.locals.asset
          link_text = tag.double? ? tag.expand : asset.title
          size = tag.attr.delete(:size) || 'original'
          if !(AppConfig.image_sizes.keys.push('original')).include?(size)
            %('#{size}' is not a valid size for asset '#{asset.id}'.)
          else
            tag.attr[:href] = asset.asset_file.url(size)
            tag.attr[:title] = link_text
            %(<a #{tag_attrs_as_xml_attrs(tag)}>#{link_text}</a>)
          end
        end

        context.define_tag 'asset:url' do |tag|
          prepare(tag)
          asset = tag.locals.asset
          link_text = tag.double? ? tag.expand : asset.title
          size = tag.attr.delete(:size) || 'original'
          if !(AppConfig.image_sizes.keys.push('original')).include?(size)
            %('#{size}' is not a valid size for asset '#{asset.id}'.)
          else
            asset.asset_file.url(size)
          end
        end

        context.define_tag 'page' do |tag|
          prepare(tag)
          check_for_required_attrs(tag, [:id, :title])
          id, title = tag.attr.delete(:id), tag.attr.delete(:title)
          if id
            page = Page.find_by_id(id)
            raise TagError.new("Page with id '#{id}' not found.") if page.nil?
          else
            Page.find(:all, :conditions => { Page.title_with_default_lang => title })
            if pages.empty?
              raise TagError.new("Page with title '#{title}' not found.")
            elsif pages.length > 1
              raise TagError.new("Page title '#{title}' is ambiguous. Use the id attribute instead.")
            end
            page = pages.first
          end
          tag.locals.page = page
          tag.expand
        end

        context.define_tag 'page:link' do |tag|
          prepare(tag)
          page = tag.locals.page
          link_text = tag.double? ? tag.expand : page.title
          tag.attr[:href] = "/#{tag.globals.lang}#{page.path}"
          %(<a #{tag_attrs_as_xml_attrs(tag)}>#{link_text}</a>)
        end

      end
    end

    def prepare(tag)
      tag.attr.symbolize_keys!
    end

    def check_for_required_attrs(*attrs)
      tag = attrs.shift
      attrs.each do |attr|
        case attr
        when Symbol
          raise TagError.new("Tag '#{tag.name}' misses required attribute '#{attr}'.") unless tag.attr.keys.include?(attr)
        when Array
          
        else
          raise StandardError.new("Error in tag #{tag.name}: each required attribute has to be a symbol or an array of symbols.")
        end
      end
    end

    def check_for_forbidden_attrs(*attrs)
      tag = attrs.shift
      attrs.each do |attr|
        raise TagError.new("Tag '#{tag.name}' contains forbidden attribute '#{attr}'.") if tag.attr.keys.include?(attr)
      end
    end

    def tag_attrs_as_xml_attrs(tag)
      tag.attr.map { |k, v| %(#{k}="#{v}") }.join(' ')
    end
  end
end
