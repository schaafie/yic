import {EditorView, EditorState, basicSetup } from "@codemirror/basic-setup";
import {json} from "@codemirror/lang-json";

const template = document.createElement('template');
template.innerHTML = `
<style>
:host {
    color: #333333;
    font: 16px Arial, sans-serif;
}

p { margin: 0; }

p.second { margin-top: 20px; }

label { 
    display: block; 
    margin-bottom: 10px;
    font-size: 16pt;
}

.error {
    display: block; 
    color: red;
    font-style: italic;
}

</style>
<p>
    <label></label>
    <div id="editor"></div>
    <div class="errors"></div>
    </p>
`;

export default class YicFormJsonInput extends HTMLElement {
    
    constructor() {
        super();
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.editor = new EditorView({
            state: EditorState.create({doc: "", extensions: [
                basicSetup, 
                EditorView.updateListener.of((v)=>{
                    if (v.docChanged) {
                        this.setAttribute("value", this.editor.state.doc.toString())
                    }
                }),
                json()
            ]}),
            parent: this._shadowRoot.querySelector("#editor")
          });
        this.$errors = this._shadowRoot.querySelector('.errors');
        this.$label = this._shadowRoot.querySelector('label');
        this.errors = [];
    }

    connectedCallback() {}

    handleValueChange( event ) {
        this.setAttribute('value', event.detail.value);
    }

    refreshErrors() {
        this.$errors.innerHTML = "";
        this.errors.forEach( error => {
            var errSpan = document.createElement('div');
            errSpan.className = 'error';
            errSpan.innerHTML = error;
            this.$errors.appendChild(errSpan);
        });
        
    }

    static get observedAttributes() { 
        return ['value', 'label' ];
    }

    attributeChangedCallback(name, oldValue, newValue) {
        switch(name) {
            case 'label':
                if (this.$label.innerHTML != newValue) {
                    this.$label.innerHTML = newValue;
                }
                break;
            case 'value':
                if (this.value != newValue) {
                    if (this.editor.state.doc.toString() != newValue) {
                        this.editor.dispatch( { changes: {from: 0, to: this.editor.state.doc.length, insert: newValue } } );
                    }
                    this.dispatchEvent(new CustomEvent('change',{ detail: {value: newValue}, bubbles: false }));
                }
                break;
        }
    }
}

window.customElements.define('yic-form-json-input', YicFormJsonInput);