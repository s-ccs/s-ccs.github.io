function toggleHamburger() {
    var status = document.getElementsByClassName("hamburger-links");
    if(status.style.display === "block") {
        status.style.display = "none";
    } else {
        status.style.display = "block";
    }
}