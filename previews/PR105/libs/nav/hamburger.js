function toggleHamburger(elem) {
    var hamburger
    var status = document.getElementById("hamburgerLinks");
    elem.classList.toggle('open');
    if(status.className === "invisible-hamburger-links") {
        status.className = "visible-hamburger-links";
    } else {
        status.className = "invisible-hamburger-links";
    }
}