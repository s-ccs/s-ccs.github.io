function hideFolder(id) {
    var status = document.getElementById(id);
    if(status.className === "second-invisible") {
        status.className = "second";
    } else {
        status.className = "second-invisible";
    }
}