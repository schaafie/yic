const template = document.createElement('template');
template.innerHTML = `<style>
:host {
    color: #333333;
    font: 16px Arial, sans-serif;
}

.panel {
    border: 1px solid red;
    border-radius: 10px;
    margin: 30px auto;
    padding: 2.0rem;
}

.debug {
    white-space: pre-line;
    white-space: pre-wrap;
    width: 100%;
}

</style>
<div class="panel">
    <button>Refresh</button>
    <div class="debug"></div>
</div>

`;

export default class YicFormDebug extends HTMLElement {

    constructor() {
        super();
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$debug = this._shadowRoot.querySelector('div.debug');
        this.$refresh = this._shadowRoot.querySelector('button');
        this.$refresh.addEventListener('click', () => { this.refresh(); });
        this.model = {};
    }

    setModel( model ) { 
        this.model = model; 
        this.model.registerListener("", this)
    }

    onChange( name, value ) {
        this.$debug.innerHTML = JSON.stringify( value, null, 2);
    }

    refresh() { 
        let value = this.model.getValue(""); 
        this.$debug.innerHTML = JSON.stringify( value, null, 2);
    }

    connectedCallback() {}

    static get observedAttributes() {}

    attributeChangedCallback(name, oldValue, newValue) {}

}

window.customElements.define('yic-form-debug', YicFormDebug);