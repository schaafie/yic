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

</style>
<div id="definitionfield">
</div>
`;

export default class YicFormDefinition extends YicSetBase {
    
    constructor() {
        super();
        this.definition = {};
        this.elementcounter = 0;
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$children = this._shadowRoot.querySelector('definitionfield');
    }

    connectedCallback() {}
    
    populateElements(element) {
        this.setAttribute('name', element.name);
    }

    static get observedAttributes() { 
        return ['value', 'name'];
    }

    attributeChangedCallback(name, oldValue, newValue) {
        switch(name) {
            case 'value':
                if (oldValue != newValue) {
                    this.value = newValue;
                }
                break;
            case 'name':
                if (oldValue != newValue) {
                    this.name = newValue;
                }
                break;
            }
    }
}

window.customElements.define('yic-form-definition', YicFormDefinition);