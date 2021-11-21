function toggleHamburger() {
    var status = document.getElementById("hamburgerLinks");
    if(status.className === "invisible-hamburger-links") {
        status.className = "visible-hamburger-links";
    } else {
        status.className = "invisible-hamburger-links";
    }
}