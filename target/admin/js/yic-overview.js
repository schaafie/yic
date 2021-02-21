import YicSetBase from './yic-set-base.js';

const template = document.createElement('template');
template.innerHTML = `<style>
:host {
    color: #333333;
    font: 16px Arial, sans-serif;
}

h2 {
    padding: 20px 50px;
    margin: 50px 50px 0px;
    border-bottom: 2px solid #ccc;
    max-width:400px;
}

.container {
    margin: 0px 50px 50px;
    padding: 20px 50px;
    max-width:600px;
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

</style>
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
</div>
`;

export default class YicOverview extends HTMLElement {
    
    constructor() {
        super();
        this.definition = { elements: [], action: "", name: "" };
        this.type = "overview";
        this.columns = [];
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$children = this._shadowRoot.querySelector('#yic-overview');
        this.$title = this._shadowRoot.querySelector('h2');
        this.$header = this._shadowRoot.querySelector('thead');
        this.$body = this._shadowRoot.querySelector('tbody');
    }

    connectedCallback() {}

    setDataRows(dr) {  
        this.dataRows = dr; 
    }
    
    setDefinition(definition) { 
        this.definition = definition; 
    }

    populate() {
        this.populateHeader();
        this.dataRows.forEach(row => {
            var docrow = document.createElement('tr');
            this.populateRow(docrow, row);
            this.$body.appendChild(docrow);
        })
    }
    populateRow(docrow, row) {
        this.columns.forEach( column => {
            var rowcol = document.createElement('td');
            switch( column.type ) {
                case "actions":
                    column.items.forEach( item => {
                        var link = document.createElement("a");
                        switch(item.method) {
                            case "DELETE":
                                link.addEventListener("click", ()=>{ this.deleteItem(row.id); });
                                link.innerHTML = "Del";
                                break;
                            case "GET":
                                link.addEventListener("click", ()=>{ this.editItem(row.id); });
                                link.innerHTML = "Edit";
                                break;
                        }                        
                        rowcol.appendChild(link);
                    });
                    break;
                default:
                    if ( row[column.datapath] ) {
                        rowcol.innerHTML = row[column.datapath];
                    }
                    break;
            }
            docrow.appendChild(rowcol);
        })
    }

    deleteItem(id) {
        console.log("Delete "+ id);
        
    }
    editItem(id) {
        console.log("Edit "+ id);
    }

    populateHeader() {
        var headerrow = document.createElement("tr");
        this.$title.innerHTML = this.definition.title;
        this.definition.elements.forEach( element => {
            var headeritem = document.createElement("th");
            headeritem.innerHTML = element.label;
            this.columns.push(element);
            headerrow.appendChild(headeritem);
        });
        this.$header.appendChild(headerrow);
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