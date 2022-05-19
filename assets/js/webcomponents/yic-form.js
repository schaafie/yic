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
}

</style>
<h2></h2>
<div class="container">
    <form id="yic-form" action="" name="" method="POST" enctype="application/x-www-form-urlencoded">
    </form>
</div>
`;

export default class YicForm extends HTMLElement {
    
    constructor() {
        super();
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$children = this._shadowRoot.querySelector('#yic-form');
        this.$title = this._shadowRoot.querySelector('h2');
    }

    connectedCallback() {}

    init( app, datamodel, definition ) {
        this.app = app;
        this.datamodel = datamodel;
        this.definition = definition;
        this.$title.innerHTML = definition.title; 
    }

    populate() {
        this.definition.elements.forEach(element => {
            switch(element.type) {
                case "hidden":
                    this.addHidden(element);
                    break;
                case "text":
                    //this.addText(element);
                    this.addInput('yic-form-text-input', element)
                    break;
                case "json":
                    // this.addJson(element);
                    this.addInput('yic-form-json-input', element)
                    break;
                case "number":
                    // this.addNumber(element);
                    this.addInput('yic-form-number-input', element)
                    break;
            }
        });

        // Add action buttons
        let div = document.createElement('div');
        let cancel = document.createElement('yic-form-action');
        cancel.setAttribute( 'label', 'Cancel');
        cancel.setSizeHalf();
        let save = document.createElement('yic-form-action');
        save.setAttribute( 'label', 'Save');
        save.setSizeHalf();
        div.appendChild(cancel);
        div.appendChild(save);

        this.$children.appendChild(div);
    }

    addHidden(element) {
        let div = document.createElement('input');
        div.type = "hidden";
        div.value = element.value;
        this.$children.appendChild(div);
    }

    addInput(inputelement, element){
        let div = document.createElement('div');
        let input = document.createElement(inputelement);
        if (element.label) input.setAttribute('label', element.label);
        if (element.name) input.setAttribute('name', element.name);
        if (this.datamodel.getValue(element.datapath)) input.setAttribute('value', this.datamodel.getValue(element.datapath));
        // Add a listener to respond to input changes and notify the datamodel
        input.addEventListener('change', (ev) =>{
            let value = ev.detail.value;
            console.log(value);
            this.datamodel.setValue(element.datapath, value);
        })
        // Register the input with the datamodel
        // This is helpfull if value in datamodel is changed by other agents
        this.datamodel.registerListener( element.datapath, input );
        // Add a callback function to respond to changes in the datamodel
        input.onChange = (datapath, value) => {
            if (input.getAttribute('value') != value) {
                input.setAttribute('value', value);
            }
        };
        div.appendChild(input);
        this.$children.appendChild(div);
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