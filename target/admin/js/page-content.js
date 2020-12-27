import dataVault from './data-vault.js';

export default class pageContent {
    constructor() {
        fetch("./js/pagedef.json").then( response => {
            return response.json();
        }).then( data => {
            this.formDef = data.form;
            this.menuDef = data.menu;
            this.dataDef = data.data;
            this.setContent();
            this.setMenu();
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
        document.querySelector("yic-form").setDataVault( new dataVault(this.dataDef) );
        document.querySelector("yic-form").setDefinition( this.formDef );
        document.querySelector("yic-form").populateForm();
    }

} 