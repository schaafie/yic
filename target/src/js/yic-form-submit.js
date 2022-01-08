const template = document.createElement('template');
template.innerHTML = `<style>
:host {
    color: #333333;
    font: 16px Arial, sans-serif;
}

p { margin-top: 20px; }

input[type="submit"] {
    font: 16px/1.6 Arial, sans-serif;
    color: white;
    background: cornflowerblue;
    border: 1px solid #1f66e5;
    border-radius: 4px;
    padding: 10px 10px;
    width: 100%;
}

</style>
<p>
    <input name="" type="submit"></input>
</p>
`;

export default class YicFormSubmit extends HTMLElement {
        constructor() {
        super();
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$form = this._shadowRoot.querySelector('#yic-form');
    }

    connectedCallback() {

    }

    static get observedAttributes() { 
        return ['value', 'label', 'required', 'name','count'];
    }

    attributeChangedCallback(name, oldValue, newValue) {
        switch(name) {
            case 'name':
                if (this._shadowRoot.querySelector('input').getAttribute('name') != newValue) {
                    this._shadowRoot.querySelector('input').setAttribute( 'name', newValue);
                }
                break;
            case 'label':
                if (this._shadowRoot.querySelector('label').innerHTML != newValue) {
                    this._shadowRoot.querySelector('label').innerHTML = newValue;
                }
                break;
            case 'value':
                if (this.value != newValue) {
                    this.value = newValue;
                }
                break;
        }
    }
}

window.customElements.define('yic-form-submit', YicFormSubmit);