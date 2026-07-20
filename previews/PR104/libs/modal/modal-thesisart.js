window.onload = function() {
    var modal_closed = document.getElementsByClassName("thesis-art")[0];
    var modal_opened = document.getElementsByClassName("thesis-art-modal")[0];

    if (modal_closed != null && modal_opened != null) {
        modal_closed.onclick = function() {
            modal_opened.classList.toggle("thesis-art-modal-invis")
        }
        
        modal_opened.onclick = function() {
            modal_opened.classList.toggle("thesis-art-modal-invis")
        }
    }
}
