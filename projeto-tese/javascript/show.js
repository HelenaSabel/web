function init() {
    var inputs = document.getElementsByClassName('show');
    for (var i = 0; i <inputs.length; i++) {
        inputs[i].addEventListener('click', show, false);
    }
}

function show(){
    this.nextElementSibling.nextElementSibling.nextElementSibling.classList.toggle('hide');
    var uls = document.getElementsByElementName('ul');
    for (var i = 0; i <uls.length; i++) {
        uls[i].previousElementSibling.previousElementSibling.previousElementSibling.addEventListener('click', destroy, false);
    }
}

function destroy() {
     this.nextElementSibling.nextElementSibling.nextElementSibling.classList.toggle('hide');
}

window.onload = init