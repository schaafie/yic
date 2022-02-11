const yic_editor_template = document.createElement('template');
yic_editor_template.innerHTML = `<div class="editor"></div>`;

export default class YicJsonEditor extends HTMLElement {
    
    constructor() {
        super();
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(yic_editor_template.content.cloneNode(true));
    }

    connectedCallback() {}

    static get observedAttributes() { 
        return ['value', 'name', 'id'];
    }

    attributeChangedCallback(name, oldValue, newValue) {
        switch(name) {
            case 'name':
                if (this.oldValue != newValue) {
                    this.name = newValue;
                }
                break;
            case 'id':
                if (this.oldValue != newValue) {
                    this.id = newValue;
                }
                break;
            case 'value':
                if (this.oldValue != newValue) {
                    this.value = newValue;
                }
                break;
        }
    }
}

window.customElements.define('yic-json-editor', YicJsonEditor);