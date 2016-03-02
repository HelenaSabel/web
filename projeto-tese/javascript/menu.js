function init() {
    var lis = document.getElementsByClassName('has-sub');
    for (var i = 0; i <lis.length; i++) {
        lis[i].addEventListener('click', tap, false);
    }
}

function tap(){
    this.classList.add('tap');
}

window.onload = init()