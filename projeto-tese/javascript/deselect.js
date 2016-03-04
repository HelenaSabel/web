function select() {
    var inputs = document.getElementsByClassName('all');
    for (var i = 0; i < inputs.length; i++) {
        inputs[i].addEventListener('click', hide, false);
    }
}

function hide() {
    this.parentNode.querySelectorAll('ul')[0].classList.add('hide');
    var boxes = this.parentElement.querySelectorAll('[name="song"]');
    for (var i = 0; i < boxes.length; i++) {
        boxes[i].checked = false;}
    
}



window.onload = select