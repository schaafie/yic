const template = document.createElement('template');
template.innerHTML = `<style>
:host {
    color: #333333;
    font: 16px Arial, sans-serif;
}

h2 {
    margin: 50px 50px 0px;
    padding: 20px 50px;
    max-width:1200px;
    border-bottom: 2px solid #ccc;
}

.container {
    margin: 0px 50px 50px;
    padding: 20px 50px;
    max-width:1200px;
}

table {
    border-collapse: collapse;
    min-width: 400px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
}

table thead tr {
    background-color: #009879;
    color: #ffffff;
    text-align: left;
}

table th,
table td {
    padding: 12px 15px;
}

tbody tr {
    border-bottom: 1px solid #dddddd;
}

tbody tr:nth-of-type(even) {
    background-color: #f3f3f3;
}

tbody tr:last-of-type {
    border-bottom: 2px solid #009879;
}

.actionbutton {
    cursor: pointer;
}

</style>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined">
<h2></h2>
<div class="container">
    <div id="yic-overview"></div>
    <table>
        <thead>
        </thead>
        <tbody>
        </tbody>
        <tfoot>
        </tfoot>
    </table>
    <button id="addbutton" class="actionbutton"><i class="material-icons-outlined">add</i>&nbsp;New</button>
</div>
`;

export default class YicOverview extends HTMLElement {
    
    constructor() {
        super();
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$children = this._shadowRoot.querySelector('#yic-overview');
        this.$title = this._shadowRoot.querySelector('h2');
        this.$header = this._shadowRoot.querySelector('thead');
        this.$body = this._shadowRoot.querySelector('tbody');
        this._shadowRoot.querySelector('#addbutton').addEventListener('click',()=>this.addItem());
    }

    connectedCallback() {}
    
    init( app, datamodel, definition ) {
        this.app = app;
        this.datamodel = datamodel;
        this.definition = definition;
        this.$title.innerHTML = definition.title; 
    }

    populate() {
        let elementlist = [];
        let pk = "";
        this.definition.elements.forEach(element => {
            if (element.pk) { pk = element.datapath; }

            if (element.type !== "hidden") {
                let tableHeader = document.createElement("th");
                tableHeader.innerHTML = element.label;
                this.$header.appendChild( tableHeader );    
                elementlist.push(element.datapath);
            }
        });

        let tableHeader = document.createElement("th");
        tableHeader.innerHTML = "Actions";
        this.$header.appendChild( tableHeader );    

        let rownum = 0;
        let rownums = this.datamodel.getValue().length;
        for(rownum;rownum<rownums;rownum++) {
            let tablerow = document.createElement('tr');
            elementlist.forEach(item => {
                let column = document.createElement('td');
                let path = `row_${rownum}.${item}`;
                column.innerHTML = this.datamodel.getValue(path);
                tablerow.appendChild( column );
            });
            let column = document.createElement('td');

            let keypath = `row_${rownum}.${pk}`;
            let del_icon = document.createElement('i');
            del_icon.classList.add("material-icons-outlined");
            del_icon.classList.add("actionbutton");
            del_icon.innerHTML = "delete";
            del_icon.addEventListener('click', () => { this.deleteItem(keypath); });
            column.appendChild(del_icon);
            column.appendChild(document.createTextNode('\u00A0'));
            
            let edit_icon = document.createElement('i');
            edit_icon.classList.add("material-icons-outlined");
            edit_icon.classList.add("actionbutton");
            edit_icon.innerHTML = "create";
            edit_icon.addEventListener('click', () => { this.editItem(keypath); });
            column.appendChild(edit_icon);

            tablerow.appendChild( column );
            this.$body.appendChild(tablerow);
        }
    }

    addItem() {
        let action = this.datamodel.createaction;
        let cmd= `${action}/0`;
        this.app.doCommand( cmd );
    }

    editItem( path ) {
        let cmd = buildaction(this.datamodel.editaction, path);
        this.app.doCommand( cmd );
    }
    
    deleteItem( path ) { 
        let pk = this.datamodel.getValue(path);
        if (this.datamodel.delete(pk)) this.populate();
    }

    static get observedAttributes() { 
        return ['value'];
    }

    attributeChangedCallback(name, oldValue, newValue) {
        switch(name) {
            case 'value':
                if (this.value != newValue) {
                    this.value = newValue;
                }
                break;
        }
    }
}

window.customElements.define('yic-overview', YicOverview);