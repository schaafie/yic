import YicSetBase from './yic-set-base.js';

const template = document.createElement('template');
template.innerHTML = `<style>
:host {
    color: #333333;
    font: 16px Arial, sans-serif;
}

p { margin: 0; }

p.second { margin-top: 20px; }

label { 
    display: block; 
    margin-bottom: 5px; 
}

input[type="text"],
input[type="password"] {
    background-color: #eaeaea;
    border: 1px solid grey;
    border-radius: 4px;
    box-sizing: border-box;
    color: inherit;
    font: inherit;
    padding: 10px 10px;
    width: 100%;
}

</style>
<p>
    <label></label>
    <input name="" type="text"></input>
</p>
`;

export default class YicFormEmailInput extends YicSetBase {
        constructor() {
        super();
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$field = this._shadowRoot.querySelector('input');
        this.$field.addEventListener('change', this.handleValueChange.bind(this));        
    }

    connectedCallback() {}

    handleValueChange( event ) {
        this.setAttribute('value', event.target.value);
        this.dataModel.setValue( this.datapath, event.target.value );
    }

    populateElements(element) {
        this.definition = element;
        this.datapath = element.datapath;
        this.setAttribute('name', element.name);
        this.setAttribute('count', this.elementcounter);
        this.setAttribute('label', element.label);
        this.setAttribute('required', element.required);
        var val = this.dataModel.getValue( element.datapath );
        if (val !==undefined)  this.setAttribute('value', val);
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
                if (this._shadowRoot.querySelector('label').innerHTML != newValue) {
                    this._shadowRoot.querySelector('label').innerHTML = newValue;
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
                if ( this.$field.getAttribute('value') != newValue ) {
                    this.$field.setAttribute('value', newValue);
                }
                break;
        }
    }
}

window.customElements.define('yic-form-email-input', YicFormEmailInput);