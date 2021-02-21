export default class pageContent {
    constructor() {
        var loc = window.location.search;
        var path = "";
        if (loc.length > 0) {
            loc = loc.substr(1);
            loc.split('&').forEach( part => {
                var parts = part.split('=');
                if (parts[0]=="path") { path = parts[1]; }
            });
        }
        path = "http://http://localhost:4000/publisher/publications/byName/" + path;

        console.log( path);

        fetch( path ).then( response => {
            return response.json();
        }).then( data => {
            this.menuDef = data.menu;
            this.setMenu();
            this.mainDef = data.main;
            this.data = data.data;
            this.dataDef = data.datadef;
            this.setContent();
        });
    }

    getApiCall() {
        return (path == "/admin/users/") ? "//yic.local.host/admin/js/pagedef_useroverview.json"
            : (path == "/admin/users/1/") ? "//yic.local.host/admin/js/pagedef_userdetail.json"
            : (path == "/admin/forms/") ? "//yic.local.host/admin/js/pagedef_formoverview.json"
            : (path == "/admin/forms/1/") ? "//yic.local.host/admin/js/pagedef_formdetail.json"
            : (path == "/admin/flows/") ? "//yic.local.host/admin/js/pagedef_formoverview.json"
            : "//yic.local.host/admin/js/pagedef.json";    
    }

    setMenu() {
        document.querySelector("yic-top-menu").setMenu( this.menuDef.topMenu );        
        if (this.menuDef.contextMenu.length == 0) {
            document.querySelector("#content").classList.remove("extended");
            document.querySelector("#content").classList.add("collapsed");
        } else {
            document.querySelector("yic-side-menu").setMenu( this.menuDef.contextMenu );
            document.querySelector("#content").classList.remove("collapsed");
            document.querySelector("#content").classList.add("extended");
        }
    }

    setContent() {
        switch(this.mainDef.type) {
            case "overview":
                var overview = document.createElement("yic-overview");
                overview.setDataRows( this.data );
                overview.setDefinition( this.mainDef );
                overview.populate();        
                document.querySelector("#main-content").appendChild(overview);
                break;
            case "detail":
                var form = document.createElement("yic-form");
                form.setDataVault( this.data, this.dataDef );
                form.setDefinition( this.mainDef );
                form.populateForm();        
                document.querySelector("#main-content").appendChild(form);
                break;
        }
    }

} 