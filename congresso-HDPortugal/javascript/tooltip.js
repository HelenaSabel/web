"use strict";

function init() {
    var gs = document.getElementsByClassName("code");
    for (var i = 0; i < gs.length; i++) {
        gs[i].addEventListener('click', popup, false);
    }
}

function popup(e) {
    if (! this.id) {
        var overlay = document.createElement("div");
        var XMousePos = e.clientX;
        var Ypos = e.clientY + 20;
        var windowWidth = window.innerWidth;
        if (windowWidth - XMousePos > 300) {
            var Xpos = XMousePos;
        } else {
            var Xpos = windowWidth - 330;
        };
        var random = "n" + Math.random();
        
        this.id = random;
        var contents = this.childNodes[2].innerHTML;
        /*var contents = this.getElementsByClassName("hide").innerHTML;*/
        overlay.innerHTML = contents
        overlay.style.backgroundColor = "black";
        overlay.style.position = "absolute";
        overlay.style.left = Xpos + "px";
        overlay.style.top = Ypos + "px";
        overlay.style.border = "1px solid darkred";
        overlay.style.borderWidth = "2px";
        overlay.style.color = "#F0F0F0";
        overlay.style.fontSize= "150%";
        /*overlay.style.opacity = "0.9"*/
        overlay.style.margin = "0";
        overlay.style.padding = ".5em";
        overlay.dataset.pointer = random;
        overlay.addEventListener('click', destroy, false);
        document.body.appendChild(overlay);
    }
}

function destroy() {
    var tooltip = document.getElementById(this.dataset.pointer);
    tooltip.removeAttribute("id");
    document.body.removeChild(this);
}

window.onload = init;