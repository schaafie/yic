const template = document.createElement('template');
template.innerHTML = `<style>
:host {
    color: #333333;
    font: 16px Arial, sans-serif;
}

p { margin: 0; }

p.second { margin-top: 20px; }

a { color: #1f66e5; }

label { 
    display: block; 
    margin-bottom: 10px;
    font-size: 16pt;
}

.error {
    display: block; 
    color: red;
    font-style: italic;
    margin-bottom: 15px;    
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
    margin-bottom: 15px;
}

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
    <label></label>
    <input name="major" type="text"></input>.<input name="medior" type="text"></input>.<input name="minor" type="text"></input>
    <div class="errors"></div>
</p>
`;

export default class YicFormVersionInput extends HTMLElement {
    
    constructor() {
        super();
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$minor = this._shadowRoot.querySelector('input[name="minor"]');
        this.$minor.addEventListener('change', this.handleMinorChange.bind(this));
        this.$major = this._shadowRoot.querySelector('input[name="major"]');
        this.$major.addEventListener('change', this.handleMajorChange.bind(this));
        this.$medior = this._shadowRoot.querySelector('input[name="medior"]');
        this.$medior.addEventListener('change', this.handleMediorChange.bind(this));
        this.$errors = this._shadowRoot.querySelector('.errors');
        this.errors = [];
    }

    connectedCallback() {}

    handleMinorChange( event ) { this.setAttribute( 'minor', event.target.value); }
    handleMediorChange( event ) { this.setAttribute( 'medior', event.target.value); }
    handleMajorChange( event ) { this.setAttribute( 'major', event.target.value); }

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
        return ['minor', 'medior', 'major', 'label', 'required', 'name', 'count'];
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
                if (this.value != newValue) {
                    this.$field.setAttribute( 'value', newValue);
                    this.dispatchEvent(new CustomEvent('change',{ detail: {value: newValue}, bubbles: false }));
                }
                break;
            case 'value':
                if (this.value != newValue) {
                    this.$field.setAttribute( 'value', newValue);
                    this.dispatchEvent(new CustomEvent('change',{ detail: {value: newValue}, bubbles: false }));
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

window.customElements.define('yic-form-version-input', YicFormVersionInput);