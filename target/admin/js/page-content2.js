import dataVault from './data-vault.js';

export default class pageContent {
    constructor() {
        fetch("./js/pagedef.json").then( response => {
            return response.json();
        }).then( data => {
            this.formDef = data.form;
            this.menuDef = data.menu;
            this.dataDef = data.data;
            this.test();
        });
    }

    test() {
        var dv = new dataVault( this.dataDef )

        console.log( dv.getValue('friends/1/last' ));

    
    }

} 