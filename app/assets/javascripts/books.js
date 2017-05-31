$(document).on('turbolinks:load', function() {

  /*
   * CREATE NEW BOOK FROM SEARCH RESULTS
   */
  // remove previous inserted elements' listeners
  $('form.search-form').on('ajax:beforeSend', function(){
    $('.search-book button').off('click');
  });


  // add listeners for new elements
  $('form.search-form').on('ajax:success', function() {
    $('.search-book button').on('click', function() {

      // get seleted book information
      var searchBook = $(this).closest('.search-book');
      var title = searchBook.find('.search-book__title').text();
      var author = searchBook.find('.search-book__author').text();
      var description = searchBook.find('.search-book__description').text();
      var cover = searchBook.find('.search-book__cover');
      var cover_image_link = '';
      if (cover.prop('style')['background-image']) {
        var bgCSSLink = cover.css('background-image');
        cover_image_link = bgCSSLink.substring(bgCSSLink.indexOf('(') + 2, bgCSSLink.indexOf(')') - 1);
      }

      // post to create new book
      $.ajax({
        context: this,
        url: '/books/create',
        method: 'POST',
        dataType: 'script',
        data: { book: { title: title, author: author, description: description, cover_image_link: cover_image_link } } })
      .done(function() {
        // change the status of added book's button
        $(this).parent().css('display', 'block');
        $(this).text('Added');
        $(this).attr('disabled', true);
        $(this).addClass('button--disabled');
      });
    });
  });


  /*
   * MANIPULATE BOOKS
   */
  $('.book button').on('click', function () {
    var book_id = $(this).closest('.book').data('book-id');
    var url = '/books/' + book_id;
    var requestType = 'PATCH';

    if ($(this).text() === 'trade') {
      // for open trading
      url += '/trade/open';
    } else if ($(this).text() === 'cancel') {
      // for cancel trading
      url += '/trade/cancel';
    } else if ($(this).text() === 'accept') {
      // for accpet trading
      url += '/trade/accept';
    } else if ($(this).text() === 'confirm to delete') {
      // for delete trading
      url += '/delete';
      requestType = 'DELETE';
    } else if ($(this).text() === 'delete') {
      $(this).removeClass('button--danger').addClass('button--destroy');
      $(this).text('confirm to delete');
      return;
    }

    $.ajax({
      context: this,
      url: url,
      method: requestType,
      dataType: 'script'})
    .done(function() {
      // change the status of added book's button
      $(this).closest('.book').remove();
    });
  });
});
