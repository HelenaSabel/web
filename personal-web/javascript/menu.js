$('.has-sub').click( function(e) {
    e.preventDefault();
    $(this).parent().toggleClass('tap');
});

