$(document).ready(function() {
  if ($('#new_page, #create_page, #edit_page, #update_page').length > 0) {
    var all_page_content_labels = $('.page_content_box label');
    var all_page_content_boxes = $('.page_content_box');

    // Add links to content boxes
    all_page_content_labels.each(function() {
      var label = this;
      all_page_content_labels.each(function() {
        var link = $('<a href="#" title="' + $(this).text() + '">' + $(this).text() + '</a>');
        var page_content_textarea_id = this.htmlFor;
        $(link).click(function() {
          $('.page_content_box').hide();
          $('#' + page_content_textarea_id + '_box').show();
        });
        if (this == label) {
          $(link).addClass('current');
        }
        $(label).before($(link));
      });
      $(this).hide();
    });

    // Sort links
    var links;
    all_page_content_boxes.each(function() {
      links = $(this).find('a').get();
      $(this).prepend(links.sort(function(a, b) {
        if ($(a).text() == $(b).text()) {
          return 0;
        }
        return ($(a).text() > $(b).text() ? 1 : -1);
      }));
    });

    // Click the first link
    $(links).slice(0, 1).click();
  }

  // Bind Alt-s to "Save and continue editing" in edit page view
  if ($('#edit_page, #update_page').length > 0) {
    $(document).bind('keydown', 'Alt+s', function(evt) {
      $('#save_and_stay').click();
    });
  }

  // Bind Alt-s to "Save and continue editing" in edit page view
  if ($('#new_page, #create_page').length > 0) {
    $(document).bind('keydown', 'Alt+s', function(evt) {
      $('#create_and_stay').click();
    });
  }
});
