$ ->
  # timeago
  $('abbr.timeago').timeago();

  # remove the url word '#_=_' after OmniAuth Facebook login.
  if window.location.hash and window.location.hash == '#_=_'
    window.location.hash = ''
    history.pushState('', document.title, window.location.pathname)

  # use fancyBox2
  $('.fancybox').fancybox();
