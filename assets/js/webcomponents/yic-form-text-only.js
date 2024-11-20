const template = document.createElement('template');
template.innerHTML = `<style>
:host {
    color: #333333;
    font: 16px Arial, sans-serif;
}
</style>
<span></span>
`;

export default class YicFormTextOnly extends HTMLElement {
    
    constructor() {
        super();
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$field = this._shadowRoot.querySelector('span');
    }

    connectedCallback() {}

    handleValueChange( event ) {}

    static get observedAttributes() { 
        return ['value'];
    }

    attributeChangedCallback(name, oldValue, newValue) {
        switch(name) {
            case 'value':
                if (this.value != newValue) {
                    this.$field.innerHTML = newValue;
                }
                break;
        }
    }
}

window.customElements.define('yic-form-text-only', YicFormTextOnly);