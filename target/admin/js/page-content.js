import dataVault from './data-vault.js';


export default class pageContent {
    constructor() {
        fetch("//yic.local.host/admin/js/pagedef_userdetail.json").then( response => {
            return response.json();
        }).then( data => {
            this.menuDef = data.menu;
            this.setMenu();
            this.mainDef = data.main;
            this.dataDef = data.data;
            this.setContent();
        });
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
                var form = document.createElement("yic-overview");
                form.setDataVault( new dataVault(this.dataDef) );
                form.setDefinition( this.mainDef );
                form.populateForm();        
                document.querySelector("#main-content").appendChild(form);
                break;
            case "detail":
                var form = document.createElement("yic-form");
                form.setDataVault( new dataVault(this.dataDef) );
                form.setDefinition( this.mainDef );
                form.populateForm();        
                document.querySelector("#main-content").appendChild(form);
                break;
        }
    }

} 