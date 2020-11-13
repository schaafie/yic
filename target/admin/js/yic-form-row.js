import {YicSetBase} from 'yic-set-base.js';

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
<div class="row">
</div>
`;

export default class YicFormRow extends YicSetBase {
    
    constructor() {
        super();
        this.definition = {};
        this.elementcouter = 0;
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$row = this._shadowRoot.querySelector('.row');
    }

    connectedCallback() {}

    _populateSet() {
        this._populate( this.definition.elements, this.$row );
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

window.customElements.define('yic-form-row', YicFormRow);