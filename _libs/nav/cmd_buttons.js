function toggleFullscreen() {
    elem =document.body; //getElementById('cmd-window');
    cursor = document.getElementsByClassName("title-text")[0]
    if(document.fullscreenElement == null) {
        elem.requestFullscreen();  
    } else {
        document.exitFullscreen();
    }
}

