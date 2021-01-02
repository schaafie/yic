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
    margin: 0px 0px 50px;
    padding: 20px 0px;
    max-width:400px;
}

#rowsheader {
    width: 100%;
    background-color: #ccc;
}

</style>
<div class="container">
    <div id="rowsheader">
        <span id="rowstitle"></span>
        <button id="addrow">+</button>
    </div>
    <div id="rowscontent"></div>
</div>
`;

export default class YicFormRows extends YicSetBase {
    
    constructor() {
        super();
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$header = this._shadowRoot.querySelector('#rowstitle');
        this.$children = this._shadowRoot.querySelector('#rowscontent');
        this.$addbutton = this._shadowRoot.querySelector('#addrow');
        this.$addbutton.addEventListener('click', this.addRow.bind(this));
    }

    addRow() { }

    removeRow(rowid) {
        var index = this.definition.elements.findIndex(element => element.rowid == rowid);
        this.definition.elements.splice( index, 1, );
        this.parent.propagateValue( this.internalId, this.definition );
        // Remove all rows that are there
        this.$children.innerHTML = "";
        // Repopulate the rows with the new definition of the rows
        this.populate(this.definition.elements, this.$children);
    }

    connectedCallback() {}

    populateElements(element) {
        this.definition = element;
        this.setAttribute('name', element.name);
        this.$header.innerHTML = element.title;
    }

    static get observedAttributes() { 
        return ['name'];
    }

    attributeChangedCallback(name, oldValue, newValue) {
        switch(name) {
            case 'name':
                if (this.name != newValue) {
                    this.name = newValue;
                }
                break;
        }
    }
}

window.customElements.define('yic-form-rows', YicFormRows);