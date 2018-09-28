document.addEventListener("DOMContentLoaded", function(event) {
    safari.extension.dispatchMessage("Hello World!");
});

document.addEventListener("contextmenu", handleContextMenu, false);
function handleContextMenu(event) {
    var selectedText =  window.getSelection().toString();
    safari.extension.setContextMenuEventUserInfo(event,
                                                 { "selectedText": selectedText });
};
//document.addEventListener("message123", handleContextMenu, false);

//safari.self.addEventListener("message", handleMessage);
//function handleMessage(event) {
////    switch event.name {
////    case "string": {
////        alert(event.message);
////        break;
////    }
////    }
//    console.log(event.name);
//    console.log(event.message);
//};
