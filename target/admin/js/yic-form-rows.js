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

#rowsheader {
    width: 100%;
    background-color: #ccc;
}

</style>
<div class="container">
    <div id="rowsheader"></div>
    <div id="rowscontent"></div>
</div>
`;

export default class YicFormRows extends YicSetBase {
    
    constructor() {
        super();
        this.definition = {};
        this.elementcouter = 0;
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$header = this._shadowRoot.querySelector('#rowsheader');
        this.$content = this._shadowRoot.querySelector('#rowscontent');
    }

    connectedCallback() {}

    _populateSet() {
        this.$header.innerHTML = this.definition.title;
        this._populate( this.definition.elements, this.$content );
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

window.customElements.define('yic-form-rows', YicFormRows);