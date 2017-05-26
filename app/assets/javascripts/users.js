$(document).on('turbolinks:load', function() {
  
  // : trading
  $('.book button').on('click', function () {
    var book_id = $(this).closest('.book').data('book-id');
    url = '/books/' + book_id + '/trade/';

    if ($(this).hasClass('button--secondary')) {
      url += 'open';
    } else if ($(this).hasClass('button--destroy')) {
      url += 'cancel';
    }

    $.ajax({
      context: this,
      url: url,
      method: 'PATCH',
      dataType: 'script'})
    .done(function() {
      // change the status of added book's button
      $(this).closest('.book').remove();
    });
  });
});
