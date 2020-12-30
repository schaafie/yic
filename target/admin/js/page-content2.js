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

        console.log( dv.getValue( 'first' ));
        dv.setValue( 'last', 'test' );
        console.log( dv.getValue( 'last' ));
        console.log( dv.getValue('friends/2/last' ));
        dv.setValue( 'friends/2/last', 'dummy' );
        console.log( dv.getValue('friends/1/last' ));
        console.log( dv.getValue('friends/2/first' ));
        console.log( dv.addSetItem( 'friends' ));
        var setid =  dv.addSetItem( 'friends' );
        dv.setValue( 'friends/'+ setid + '/first', 'first' );
        dv.setValue( 'friends/'+ setid + '/last', 'last' );
        console.log( dv.hasElement('first') );
        console.log( dv.hasElement('second') );
        console.log( dv.hasElement('friends/1/first') );
        console.log( dv.hasElement('friends/5/first') );
        console.log( dv.hasElement('friends/2/second') );
        console.log( dv.getSetItems('friends/1') );
    }

} 