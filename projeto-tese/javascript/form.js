
function formulario() {
    var inputs = document.querySelectorAll('input');
    for (var i = 0; i < inputs.length; i++) {
        inputs[i].addEventListener('click', giveID, false);
    }
}

function giveID() {
    var id = this.getAttribute('value');
    var ams = document.getElementsByClassName('am');
    var expans = document.getElementsByClassName('expansion');
    var regs = document.getElementsByClassName('reg');
    var origs = document.getElementsByClassName('orig');
    var apostrophes = document.getElementsByClassName('supplied');
    var dels = document.querySelectorAll('del');
    var adds = document.querySelectorAll('ins');
    
    switch (id) {
        
        case 'abb':
        for (var i = 0; i < ams.length; i++) {
            ams[i].style.display = 'inline-block';
        }
        for (var i = 0; i < expans.length; i++) {
            expans[i].style.display = 'none';
        }
        
        break;
        
        case 'expan':
        for (var i = 0; i < ams.length; i++) {
            ams[i].style.display = 'none';
        }
        for (var i = 0; i < expans.length; i++) {
            expans[i].style.display = 'inline-block';
        }
        
        break;
        
        case 'reg':
        for (var i = 0; i < regs.length; i++) {
            regs[i].style.display = 'inline-block';
        }
        for (var i = 0; i < origs.length; i++) {
            origs[i].style.display = 'none';
        }
        
        break;
        
        case 'orig':
        for (var i = 0; i < regs.length; i++) {
            regs[i].style.display = 'none';
        }
        for (var i = 0; i < origs.length; i++) {
            origs[i].style.display = 'inline-block';
        }
        
        break;
        
        case 'apostrophe':
        for (var i = 0; i < apostrophes.length; i++) {
            apostrophes[i].classList.toggle('hide');
        }
        
        break;
        
        case 'del':
        for (var i = 0; i < dels.length; i++) {
            dels[i].classList.toggle('hide');
        
        if (dels[i].classList.contains('underdot')) {
            var letters = dels[i].textContent.split('');
            var output = '';
            for (var j = 0; j < letters.length; j++) {
                output += (letters[j] + '&#803;');
            }
            dels[i].innerHTML = output;
        }
        if (dels[i].classList.contains('multiple-overstrike')) {
            var letters = dels[i].textContent.split('');
            var output2 = '';
            for (var y = 0; y < letters.length; j++) {
                output += (letters[y] + '&#824;');
            }
            dels[i].innerHTML = output2;
        }
        
        if (dels[i].classList.contains('scrape')) {
            dels[i].style.opacity = '0.9';
        }
        }
        
        break;
        
        case 'add':
        for (var i = 0; i < adds.length; i++) {
            adds[i].classList.toggle('enhance');
        }
    }
}

window.addEventListener('load', formulario, false);