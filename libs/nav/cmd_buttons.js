function toggleFullscreen() {
    elem = document.getElementById('cmd-window');
    cursor = document.getElementsByClassName("title-text")[0]
    if(document.fullscreenElement == null) {
        elem.requestFullscreen();  
    } else {
        document.exitFullscreen();
    }
}

function closeWindow() {
    document.getElementById('cmd-window').classList.add("window-fade") //style.display = "none";
}

