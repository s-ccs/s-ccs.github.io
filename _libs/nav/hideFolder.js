function hideFolder(id) {
    var status = document.getElementById(id + "-folder");
    var icon = document.getElementById(id + "-folder-icon");
    if(status.className === "second-invisible") {
        status.className = "second";
        icon.className = "fas fa-chevron-circle-down";
    } else {
        status.className = "second-invisible";
        icon.className = "fas fa-chevron-circle-right";
    }
}