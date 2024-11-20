const template = document.createElement('template');
template.innerHTML = `<style>
:host {
    color: #333333;
    font: 16px Arial, sans-serif;
}

</style>
<span>
</span>
`;

export default class YicFormVersionOnly extends HTMLElement {
    
    constructor() {
        super();
        this.major = 0;
        this.medior = 0;
        this.minor = 0;
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$field = this._shadowRoot.querySelector('span');
    }

    setVersion() { this.$field.innerHTML = `${this.major}.${this.medior}.${this.minor}`; }

    connectedCallback() {}

    static get observedAttributes() {  return ['minor', 'medior', 'major']; }

    attributeChangedCallback(name, oldValue, newValue) {
        if (oldValue !== newValue) {
            switch(name) {
                case 'minor':
                    this.minor = newValue;
                    break;
                case 'medior':
                    this.medior = newValue;
                    break;
                case 'major':
                    this.major = newValue;
                    break;
            } 
            this.setVersion();
        }
    }
}

window.customElements.define('yic-form-version-only', YicFormVersionOnly);