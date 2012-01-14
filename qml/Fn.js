
var folderPositionCache = {}

function addFolderPosition(path, index) {
    if (index >= 0)
        folderPositionCache[path] = index;
}

function getFolderPosition(path) {
    var index = folderPositionCache[path];

    return index >= 0 ? index : 0;
}
