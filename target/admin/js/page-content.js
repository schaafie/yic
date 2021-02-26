export default class pageContent {
    constructor() {
        fetch( this.buildPath() ).then( response => {
            return response.json();
        }).then( data => {
            var def = data.data.definition;
            this.setMenu( def.menu );
            this.setContent( def.main, def.data, def.datadef);
        });
    }

    buildPath() {
        var loc = window.location.search;
        var path = "";
        if (loc.length > 0) {
            loc = loc.substr(1);
            loc.split('&').forEach( part => {
                var parts = part.split('=');
                if (parts[0]=="path") { 
                    path = parts[1]; 
                    var pathElements = path.split('/');
                    if (pathElements.length <= 2) {
                        path = "name=" + path;
                    } else {
                        var lastElement = pathElements.pop();
                        if (!isNaN(parseInt(lastElement))) {
                            pathElements.push('@id');
                            path = "name=" + pathElements.join('/') + "&id=" + lastElement;
                        } else {
                            path = "name=" + path;
                        }
                    }
                }
            });
        }
        return "http://yic.local.host:4000/publisher/publications/byname?" + path;
    }

    setMenu(menuDef) {
        document.querySelector("yic-top-menu").setMenu( menuDef.topMenu );        
        if (menuDef.contextMenu.length == 0) {
            document.querySelector("#content").classList.remove("extended");
            document.querySelector("#content").classList.add("collapsed");
        } else {
            document.querySelector("yic-side-menu").setMenu( menuDef.contextMenu );
            document.querySelector("#content").classList.remove("collapsed");
            document.querySelector("#content").classList.add("extended");
        }
    }

    setContent(main, data, datadef) {
        switch(main.type) {
            case "overview":
                var overview = document.createElement("yic-overview");
                overview.setDataRows( data );
                overview.setDefinition( main );
                overview.populate();        
                document.querySelector("#main-content").appendChild(overview);
                break;
            case "detail":
                var form = document.createElement("yic-form");
                form.setDataVault( data, datadef );
                form.setDefinition( main );
                form.populateForm();        
                document.querySelector("#main-content").appendChild(form);
                break;
        }
    }
} 