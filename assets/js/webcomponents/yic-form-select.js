const template = document.createElement('template');
template.innerHTML = `<style>
:host {
    color: #333333;
    font: 16px Arial, sans-serif;
}

p { margin: 0; }

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

select {
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

</style>
<p>
    <label></label>
    <select name="">
        <option value="0">Loading...<option>
    </select>
    <div class="errors"></div>
</p>
`;

export default class YicFormSelect extends HTMLElement {
    
    constructor() {
        super();
        this.optionsData = [];
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$field = this._shadowRoot.querySelector('select');
        this.$field.addEventListener('change', this.handleValueChange.bind(this));
        this.$errors = this._shadowRoot.querySelector('.errors');
        this.errors = [];
    }

    connectedCallback() {}

    handleValueChange( event ) {
        this.setAttribute('value', event.target.value);
    }

    setOptions( value, display ) {
        this.ValueKey = value;
        this.displayKeys = display;
    }

    optionsChange(data) {
        let children = this.$field.getElementsByTagName("option");
        for (const child of children) this.$field.removeChild( child);

        for (const item of data) {
            let node = document.createElement("option");
            node.value = item[this.ValueKey];
            node.innerHTML = `${item[this.displayKeys[0]]} ${item[this.displayKeys[1]]}`;
            this.$field.appendChild(node);

            if (this.value) this.$field.value = this.value;
        }
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
        return ['value', 'label', 'required', 'name'];
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
            case 'required':
                if (newValue == "true") {

                } else {

                }
                break;
            case 'value':
                if (this.value != newValue) {
                    this.value = newValue;
                    this.$field.setAttribute( name, newValue);
                    this.dispatchEvent(new CustomEvent('change',{ detail: {value: newValue}, bubbles: false }));
                }
                break;
        }
    }
}

window.customElements.define('yic-form-select', YicFormSelect);