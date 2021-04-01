const template = document.createElement('template');
template.innerHTML = `<style>
:host {
    color: #333333;
    font: 16px Arial, sans-serif;
}

button {
    font: 16px/1.6 Arial, sans-serif;
    color: white;
    background: cornflowerblue;
    border: 1px solid #1f66e5;
    border-radius: 4px;
    padding: 5px 5px;
    margin:5px;
    width: 100%;
}

</style>
<button>BUTTON</button>
`;

export default class YicFormAction extends HTMLElement {

    constructor() {
        super();
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$button = this._shadowRoot.querySelector('button');
    }

    connectedCallback() {

    }

    static get observedAttributes() { 
        return ['label', 'name'];
    }

    attributeChangedCallback(name, oldValue, newValue) {
        switch(name) {
            case 'name':
                if (this.$button.getAttribute('name') != newValue) {
                    this.$button.setAttribute( 'name', newValue);
                }
                break;
            case 'label':
                if (this.$button.innerHTML != newValue) {
                    this.$button.innerHTML = newValue;
                }
                break;
        }
    }
}

window.customElements.define('yic-form-action', YicFormAction);