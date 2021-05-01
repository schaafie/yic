import YicSetBase from './yic-set-base.js';
import dataVault from './data-vault.js';


const template = document.createElement('template');
template.innerHTML = `<style>
:host {
    color: #333333;
    font: 16px Arial, sans-serif;
}

h2 {
    padding: 20px 50px;
    margin: 50px 50px 0px;
    border-bottom: 2px solid #ccc;
    max-width:400px;
}

.container {
    margin: 0px 50px 50px;
    padding: 20px 50px;
    max-width:400px;
}

</style>
<h2></h2>
<div class="container">
    <form id="yic-form" action="" name="" method="POST" enctype="application/x-www-form-urlencoded">
    </form>
</div>
`;

export default class YicForm extends YicSetBase {
    
    constructor() {
        super();
        this.pageElement = {};
        this.definition = { elements: [], action: "", name: "" };
        this.elementcounter = 0;
        this.type = "form";
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$children = this._shadowRoot.querySelector('#yic-form');
        this.$title = this._shadowRoot.querySelector('h2');
    }

    setDataVault(data, dataDef) { 
        this.datavault = new dataVault( data, dataDef ); 
    }

    setDefinition(pageElement) { 
        this.pageElement = pageElement;
        this.definition = pageElement.definition; 
        this.formActions = pageElement.definition.formactions; 
    }

    populateForm() {
        this.$title.innerHTML = this.definition.title;
        this.populate( this.definition.elements, this.datavault, this.$children );
        // Place submit button
        var button = document.createElement("yic-form-submit");
        button.addEventListener('click', this.submitForm.bind(this));
        this.$children.appendChild(button);
    }

    propagateValue( id, val ) {
        if ( id.startsWith( this.internalId ) ) {
            var elementname = this.internalId.substring( id.length );
            this.definition.elements.forEach( (element, index) => {
                if (element.name == elementname) {
                    element.value = val;
                    this.definition.elements[index] = element;
                }
            });
        }
    }

    submitForm() {
        this.datavault.save( this.handleError.bind(this), this.handleSucces.bind(this) );
    }

    handleError( txt ) {
        console.log( "Error: " + txt );
    }

    handleSucces() {
        console.log( "Succes: " + txt );
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

window.customElements.define('yic-form', YicForm);