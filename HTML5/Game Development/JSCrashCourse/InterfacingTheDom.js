
var manipulateDOM = function() {
    // YOUR CODE HERE
    body = document.getElementById("body");
    
    gamecontent = document.createElement("div");
    gamecontent.id = "gameContent";
    
    gamecanvas = document.createElement("canvas");
    gamecanvas.id = "gameCanvas";
    
    gamecontent.appendChild(gamecanvas);
    body.appendChild(gamecontent);
};

