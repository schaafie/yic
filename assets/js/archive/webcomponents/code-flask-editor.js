import CodeFlask from 'codeflask';
import Prism from 'prismjs';

const yic_editor_template = document.createElement('template');
yic_editor_template.innerHTML = `
<style>
    #editor {
        height: 420px;
    }

    div.codeflask {
        height: 400px;
        border: 1px solid grey;
        padding: 0.6rem 1rem 0.7rem;
        border: 0.1rem solid #d1d1d1;
        border-radius: 0.4rem;
    }

</style>
<div id="editor">
</div>`;

export default class CodeFlaskEditor extends HTMLElement {

    constructor() {
        super();
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(yic_editor_template.content.cloneNode(true));
        const shadowElem = this._shadowRoot.querySelector('#editor');
        this.flask = new CodeFlask(shadowElem, { language: 'json', lineNumbers: true, styleParent: this._shadowRoot }); 
        this.flask.addLanguage('json', Prism.languages['json']);       
        // keep reference to <form> for cleanup
        this._form = null;
        this._handleFormData = this._handleFormData.bind(this);        
    }

    // attributeChangedCallback will be called when the value of one of these attributes is changed in html
    static get observedAttributes() { return ['value']; }

    attributeChangedCallback(name, oldValue, newValue) {
        if (this.flask) {
            if (name === 'value' && this.value!==newValue) {
                this.flask.updateCode(newValue);
            }
        }
    }

    connectedCallback() {
        this._form = this._findContainingForm();
        if (this._form) this._form.addEventListener('formdata', this._handleFormData);
    }

    disconnectedCallback() {
        if (this._form) {
            this._form.removeEventListener('formdata', this._handleFormData);
            this._form = null;
        }
    }

    _getEditorValue() {
        if (this.flask) {
            return this.flask.getCode();
        } else {
            return null;
        }
    }

    _handleFormData(ev) {
        ev.formData.append(this.getAttribute('name'), this._getEditorValue());
    }

    _findContainingForm() {
        // can only be in a form in the same "scope", ShadowRoot or Document
        const root = this.getRootNode();
        if (root instanceof Document || root instanceof Element) {
            const forms = Array.from(root.querySelectorAll('form'));
            // we can only be in one <form>, so the first one to contain us is the correct one
            return forms.find((form) => form.contains(this)) || null;
        }
        return null;
    }
}

customElements.define('code-flask-editor', CodeFlaskEditor);