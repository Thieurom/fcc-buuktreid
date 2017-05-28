$(document).on('turbolinks:load', function() {
  
  $('.book button').on('click', function () {
    var book_id = $(this).closest('.book').data('book-id');
    url = '/books/' + book_id + '/trade/';

    if ($(this).hasClass('button--secondary')) {
      url += 'accept';
    } else if ($(this).hasClass('button--destroy')) {
      url += 'cancel';
    }

    $.ajax({
      context: this,
      url: url,
      method: 'PATCH',
      dataType: 'script'})
    .done(function() {
      if ($(this).hasClass('button--destroy')) {
        // change the status of added book's button
        $(this).closest('.book').remove();
      }
    });
  });
});
