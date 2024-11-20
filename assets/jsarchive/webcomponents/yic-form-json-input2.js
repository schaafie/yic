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
    <codejar-editor language="json" class="language-json"></codejar-editor>
    <div class="errors"></div>
    </p>
`;

export default class YicFormJsonInput extends HTMLElement {
    
    constructor() {
        super();
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$field = this._shadowRoot.querySelector('codejar-editor');
        this.$errors = this._shadowRoot.querySelector('.errors');
        this.$label = this._shadowRoot.querySelector('label');
        this.$field.addEventListener('change', this.handleValueChange.bind(this));
    }

    connectedCallback() {}

    handleValueChange( event ) {
        this.setAttribute('value', event.detail.value);
    }

    updateErrors( path ) {
        this.$errors.innerHTML = "";
        errors.forEach( error => {
            var errSpan = document.createElement('div');
            errSpan.className = 'error';
            errSpan.innerHTML = error;
            this.$errors.appendChild(errSpan);
        });
        
    }

    static get observedAttributes() { 
        return ['value', 'label', 'required', 'name','count'];
    }

    attributeChangedCallback(name, oldValue, newValue) {
        switch(name) {
            case 'name':
                if (this.$field.getAttribute('name') != newValue) {
                    this.name = newValue;
                    this.$field.setAttribute( 'name', newValue);
                }
                break;
            case 'label':
                if (this.$label.innerHTML != newValue) {
                    this.$label.innerHTML = newValue;
                }
                break;
            case 'count':
                if (newValue > 1) {
                    this._shadowRoot.querySelector('p').classList.add("second");
                }
                break;
            case 'required':
                if (newValue == "true") {

                } else {

                }
                break;
            case 'value':
                if (this.value != newValue) {
                    this.$field.setAttribute( 'value', newValue);
                    this.dispatchEvent(new CustomEvent('change',{ detail: {value: newValue}, bubbles: false }));
                }
                break;
        }
    }
}

window.customElements.define('yic-form-json-input', YicFormJsonInput);