export default class YicSetBase extends HTMLElement {
    
    constructor() {
        super();
        this.definition = {};
        this.elementcouter = 0;
    }

    connectedCallback() {}

    setDefinition(definition) {
        this.definition = definition;
        this._populateSet();
        return this.elementcounter;
    }

    _populateSet() {}

    _populate( elements, elementcouter, localroot ) {
        elements.forEach(element => {
            this.elementcouter++;
            switch(element.type) {
                case "text":
                    var input = document.createElement("yic-form-text-input");
                    input.setAttribute('name', element.name);
                    input.setAttribute('count', this.elementcouter);
                    input.setAttribute('label', element.label);
                    input.setAttribute('required', element.required);
                    localroot.appendChild(input)
                    break;
                case "email":
                    var input = document.createElement("yic-form-email-input");
                    input.setAttribute('name', element.name);
                    input.setAttribute('count', this.elementcouter);
                    input.setAttribute('label', element.label);
                    input.setAttribute('required', element.required);
                    localroot.appendChild(input)
                    break;
                case "set":
                    var set = document.createElement("yic-form-rows");
                    set.setAttribute('name', element.name);
                    this._populate(element.rows, set);
                    localroot.appendChild(set);
                    break;                    
                case "row":
                    var row = document.createElement("yic-form-row");
                    row.setAttribute('name', element.name);
                    this._populate(element.elements, row);
                    localroot.appendChild(row);
                    break;                    
                case "definition":
                    var definition = document.createElement("yic-form-definition");
                    definition.setAttribute('name', element.name);
                    definition.elementcounter = this.elementcounter;
                    this.elementcounter = definition.setDefinition(element.elements);
                    localroot.appendChild(definition);
                    break;                    
            }
        });
    }

    static get observedAttributes() { 
        return ['value'];
    }

    attributeChangedCallback(name, oldValue, newValue) {
        switch(name) {
            case 'value':
                if (this.value != newValue) {
                    this.value = newValue;
                }
                break;
        }
    }
}

window.customElements.define('yic-set-base', YicSetBase);