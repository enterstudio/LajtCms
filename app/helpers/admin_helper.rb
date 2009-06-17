module AdminHelper
  def admin_page_title_helper
    controller_name = if %w(show create edit update new).include?(controller.action_name)
      controller.controller_name.singularize
    else
      controller.controller_name
    end
    returning title = "#{controller.action_name.capitalize} #{controller_name}" do
      if @page.try(:title)
        title << %( "#{@page.title}")
      elsif @asset.try(:title)
        title << %( "#{@asset.title}")
      end
    end
  end

  def flash_helper
    flash.map do |level, message|
      content_tag :div, message, :class => (level == :notice ? :success : level)
    end
  end

  def error_messages_for(*params)
    options = params.extract_options!.symbolize_keys
    objects = if object = options.delete(:object)
      [object].flatten
    else
      params.collect { |object_name| instance_variable_get("@#{object_name}") }.compact
    end
    count = objects.inject(0) { |sum, object| sum + object.errors.count }
    if count.zero?
      nil
    else
      error_messages = objects.map { |object| object.errors.map { |e| "#{e.first.humanize} #{e.last}" }.join('<br>') }
      content_tag :div, error_messages, :class => 'error'
    end
  end
end
