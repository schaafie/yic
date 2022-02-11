import {CodeJar} from 'codejar';
import Prism from 'prismjs';
import {withLineNumbers} from 'codejar/linenumbers';
import 'prismjs/components/prism-json';

export default class CodejarEditor extends HTMLElement {

    constructor() {
        super();
        this.innerHTML = '<div id="editor" class="language-json"></div>';
        this.$editor = this.querySelector('#editor');
        this.editor = new CodeJar(this.$editor, withLineNumbers(Prism.highlightElement)); 
        // keep reference to <form> for cleanup
        this._form = null;
        this._handleFormData = this._handleFormData.bind(this);        
    }

    // attributeChangedCallback will be called when the value of one of these attributes is changed in html
    static get observedAttributes() { return ['value']; }

    attributeChangedCallback(name, oldValue, newValue) {
        if (this.editor) {
            if (name === 'value' && this.value!==newValue) {
                this.editor.updateCode(newValue);
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
        if (this.editor) {
            return this.editor.getCode();
        } else {
            return null;
        }
    }

    _handleFormData(ev) {
        ev.formData.append(this.getAttribute('name'), this.editor.toString());
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

customElements.define('codejar-editor', CodejarEditor);