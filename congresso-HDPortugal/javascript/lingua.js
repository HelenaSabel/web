/* An important part of the code was copied of lgToggle.js by David J. Birnbaum at http://repertorium.obdurodon.org */


function createCookie(name, value, days) {
  if (days) {
    var date = new Date();
    date.setTime(date.getTime() +(days * 24 * 60 * 60 * 1000));
    var expires = "; expires=" + date.toGMTString();
  } else var expires = "";
  document.cookie = name + "=" + value + expires + "; path=/";
}

function readCookie(name) {
  var nameEQ = name + "=";
  var ca = document.cookie.split(';');
  for (var i = 0; i < ca.length; i++) {
    var c = ca[i];
    while (c.charAt(0) == ' ') c = c.substring(1, c.length);
    if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
  }
  return null;
}



 function init () {
  var initials = document.getElementsByClassName('initial');
  for (i = 0; i < initials.length; i++) {
   initials[i].addEventListener('click', changeLang, false);
  }
  var lang = readCookie('lg');
  createCookie('lg',lang,30);
  changeLang();
}

 function changeLang() {
  if (typeof this.id === 'undefined') {var id = readCookie('lg')} else {var id = this.id;}
  createCookie('lg',id,30);
  var sps = document.getElementsByClassName('sp');
  var spsLength = sps.length;
  var pts = document.getElementsByClassName('pt');
  var ptsLength = pts.length;
  var initialButtons = document.querySelectorAll('.initial > span');
  var initialButtonsLength = initialButtons.length;
  for (i = 0; i < initialButtonsLength; i++) {
    if (initialButtons[i].parentNode.id == id) {
      initialButtons[i].parentNode.style.boxShadow = '4px 4px 4px black';
    } else {
      initialButtons[i].parentNode.style.boxShadow = 'none';
    }
  }
  switch (id) {
    case 'sp':
    for (var i = 0; i < spsLength; i++) {
      sps[i].style.display = 'block';
    }
    for (var i = 0; i < ptsLength; i++) {
      pts[i].style.display = 'none';
    }
    break;
    case 'pt':
    for (var i = 0; i < spsLength; i++) {
      sps[i].style.display = 'none';
    }
    for (var i = 0; i < ptsLength; i++) {
      pts[i].style.display = 'block';
    }
    
  }
}

 window.addEventListener('load',init,false);
