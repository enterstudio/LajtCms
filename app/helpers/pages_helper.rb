module PagesHelper
  def page_title_helper
    @page.title(params[:lang], true)
  end

  def page_tree_helper(pages)
    "<ul>#{page_tree_items_helper(Array(pages), 1)}</ul>"
  end

  def page_tree_items_helper(pages, level)
    returning page_tree_items = '' do
      pages.each do |page|
        page_tree_items << %(<li class="level-#{level}">)
        page_tree_items << link_to_unless_current(page.title(params[:lang]), show_page_path(:path => page.path_array))
        page_tree_items << '</li>'
        unless page.children.empty?
          next_level = page == Page.root ? level : level + 1
          page_tree_items << page_tree_items_helper(page.children, next_level)
        end
      end
    end
  end

  def languages_helper
    AppConfig.languages.map do |language, lang|
      link_to language.capitalize, show_page_path(:path => @page.path_array, :lang => lang) unless lang == params[:lang]
    end.compact.join('<br>')
  end
end
