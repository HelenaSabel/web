"use strict";

function init() {
    var spans = document.querySelectorAll('[data-ana],[data-ling]')
for (var i = 0; i < spans.length; i++) {
        spans[i].addEventListener('click', popup, true);
    }
}


function popup(event) {
    if (! this.id) {
        var overlay = document.createElement("div");
        var x = event.pageX;
        var y = event.pageY;
        var random = "n" + Math.random();
        
        this.id = random;
        if (this.dataset.ana) {
            overlay.innerHTML = this.dataset.ana;
        }
        if (this.dataset.ling) {
            overlay.innerHTML = this.dataset.ling;
        }
        overlay.style.backgroundColor = "#444";
        overlay.style.position = "absolute";
        overlay.style.left = x + "px";
        overlay.style.top = y + "px";
        overlay.style.border = "2px solid #610000;";
        overlay.style.borderWidth = "2px";
        overlay.style.color = "#EEEEEE";
        overlay.style.opacity = "0.9"
        overlay.style.margin = "0";
        overlay.style.padding = ".5em";
        overlay.dataset.pointer = random;
        overlay.addEventListener('click', destroy, false);
        document.body.appendChild(overlay);
    }
}

function destroy() {
    var span = document.getElementById(this.dataset.pointer);
    span.removeAttribute("id");
    document.body.removeChild(this);
}

window.onload = init;