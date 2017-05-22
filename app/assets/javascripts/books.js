$(document).on('turbolinks:load', function() {

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
      var bgCSSLink = searchBook.find('.search-book__cover').css('background-image');
      var cover_image_link = bgCSSLink.substring(bgCSSLink.indexOf('(') + 2, bgCSSLink.indexOf(')') - 1);

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
});
