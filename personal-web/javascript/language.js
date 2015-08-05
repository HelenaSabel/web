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
  var gls = document.getElementsByClassName('gl');
  var glsLength = gls.length;
  var ens = document.getElementsByClassName('en');
  var ensLength = ens.length;
  var initialImgs = document.querySelectorAll('.initial > img');
  var initialImgsLength = initialImgs.length;
  for (i = 0; i < initialImgsLength; i++) {
    if (initialImgs[i].parentNode.id == id) {
      initialImgs[i].style.boxShadow = '4px 4px 4px darkred';
    } else {
      initialImgs[i].style.boxShadow = 'none';
    }
  }
  switch (id) {
    case 'gl':
    for (var i = 0; i < glsLength; i++) {
      gls[i].style.display = 'block';
    }
    for (var i = 0; i < ensLength; i++) {
      ens[i].style.display = 'none';
    }
    break;
    case 'en':
    for (var i = 0; i < glsLength; i++) {
      gls[i].style.display = 'none';
    }
    for (var i = 0; i < ensLength; i++) {
      ens[i].style.display = 'block';
    }
    
  }
}

 window.addEventListener('load',init,false);
