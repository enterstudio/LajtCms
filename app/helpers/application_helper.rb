module ApplicationHelper
  def body_id_helper
    controller_name = if %w(create edit update new show).include?(controller.action_name)
      controller.controller_name.singularize
    else
      controller.controller_name
    end
    "#{controller.action_name}_#{controller_name}"
  end
  
    def page_e_info(collection)
      %{Wyświetlanie wpisów <b>%d&nbsp;-&nbsp;%d</b> z <b>%d</b> wszystkich} % [
        collection.offset + 1,
        collection.offset + collection.length,
        collection.total_entries
      ]
    end
end
