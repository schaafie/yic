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
        this.pageElement = {};
        this.definition = { elements: [], action: "", name: "" };
        this.type = "overview";
        this.columns = [];
        this.formActions = [];
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$children = this._shadowRoot.querySelector('#yic-overview');
        this.$title = this._shadowRoot.querySelector('h2');
        this.$header = this._shadowRoot.querySelector('thead');
        this.$body = this._shadowRoot.querySelector('tbody');
    }

    connectedCallback() {}

    setdataModel( data, datadef ) {
        this.dataModel = new dataModel( data, datadef ); 
    }
    
    setDefinition(pageElement) { 
        this.pageElement = pageElement;
        this.definition = pageElement.definition; 
    }

    populate() {
        this.populateHeader();
        var numRows = this.dataModel.rowCount();
        for (var i=0;i<numRows;i++) {
            var docrow = document.createElement('tr');
            this.populateRow(docrow, i);
            this.$body.appendChild(docrow);
        }
    }

    handleCall( id ) {
        if (this.formActions[id].type == "FORM") {
            var action = new String( this.formActions[id].action.url );
            var url = action.replace( /@id/i, this.formActions[id].element.value );
            window.location.href = url;
        } else {
            
        }
    }

    populateRow(docrow, rowindex) {
        this.columns.forEach( column => {
            var rowcol = document.createElement('td');
            switch( column.type ) {
                case "actions":
                    column.items.forEach( item => {
                        rowcol.appendChild(this.createActionButton( item, rowindex ));
                    });
                    break;
                default:
                    var element = this.dataModel.getSetElement( rowindex, column.datapath );
                    rowcol.innerHTML = element.value;
                    break;
            }
            docrow.appendChild(rowcol);
        })
    }

    createActionButton( item, rowindex ) {
        // Create action
        var actionId    = this.CreateFormAction( item, rowindex );
        // Create Button
        var button      = document.createElement("yic-form-action");
        button.setAttribute("label", item.label);
        // Add action to button
        button.addEventListener( 'click', () => { 
            this.handleCall( actionId ); 
        });
        return button;
    }

    CreateFormAction( item, rowindex ) {
        var actionId;

        if (item.object == "FORM") {
            this.definition.formactions.forEach( formaction => {
                if (formaction.id == item.action) {
                    var handlerObject   = {};
                    handlerObject.action    = formaction.action;
                    handlerObject.element   = this.dataModel.getSetElement( rowindex, "id" );
                    handlerObject.type      = item.object;
                    // Add object to action stack and save the entry position (thus -1 because push results in length of array)
                    actionId = this.formActions.push( handlerObject ) - 1;
                }
            });
        } else if (item.object == "DATA") {
            this.dataModel.actions.forEach( formaction => {
                if (formaction.id == item.action) {
                    var handlerObject   = {};
                    handlerObject.action    = formaction.action;
                    handlerObject.element   = this.dataModel.getSetElement( rowindex, "id" );
                    handlerObject.type      = item.object;
                    // Add object to action stack and save the entry position (thus -1 because push results in length of array)
                    actionId = this.formActions.push( handlerObject ) - 1;
                }
            });
        }
        return actionId;
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