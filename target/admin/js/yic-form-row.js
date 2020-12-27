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
    max-width:400px;
}

.row {
    width: 100%;
}
</style>
<div>
    <div class="rowheader">
        <button id="removerow">-</button>
    </div>
    <div class="rowcontent"></div>
</div>
`;

export default class YicFormRow extends YicSetBase {
    
    constructor() {
        super();
        this.elementcouter = 0;
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$children = this._shadowRoot.querySelector('.rowcontent');
        this.$button = this._shadowRoot.querySelector('#removerow');
        this.$button.addEventListener('click', this.removeRow.bind(this));
    }

    propagateValue( id, val ) {
        if ( id.startsWith( this.internalId ) ) {
            var elementname = this.internalId.substring( id.length );
            this.definition.elements.forEach( (element, index) => {
                if (element.name == elementname) {
                    element.value = val;                    
                    this.definition.elements[index] = element;
                }
            });
        }
        this.parent.propagateValue( this.internalId, this.definition );
    }

    connectedCallback() {}

    removeRow() {
        this.parent.removeRow( this.rowid );
    }

    populateElements(element) {
        this.definition = element;
        this.setAttribute('name', element.name);
        this.setAttribute('rowid', element.rowid);
    }

    static get observedAttributes() { 
        return ['name', 'rowid'];
    }

    attributeChangedCallback(name, oldValue, newValue) {
        switch(name) {
            case 'name':
                if (oldValue != newValue) {
                    this.name = newValue;
                }
                break;
            case 'rowid':
                if (oldValue != newValue) {
                    this.rowid = newValue;
                }
                break;
            }
    }
}

window.customElements.define('yic-form-row', YicFormRow);