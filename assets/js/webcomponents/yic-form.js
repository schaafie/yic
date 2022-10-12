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
<form id="yic-form" action="" name="" method="POST" enctype="application/x-www-form-urlencoded">
</form>
`;

export default class YicForm extends HTMLElement {
    
    constructor() {
        super();
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$children = this._shadowRoot.querySelector('#yic-form');
    }

    connectedCallback() {}

    init( app, datamodel, definition ) {
        this.app = app;
        this.datamodel = datamodel;
        this.definition = definition;
    }

    populate() {
        this.addElements(this.definition.elements, this.$children);

        // Add action buttons
        let div = document.createElement('div');
        let save = document.createElement('yic-form-action');
        save.setAttribute( 'label', 'Save');
        save.addEventListener('click', (ev)=>{ this.datamodel.save(); });
        div.appendChild(save);
        this.$children.appendChild(div);
    }

    addElements(elements, node) {
        elements.forEach(element => {
            switch(element.type) {
                case "hidden":
                    this.addHidden(node, element);
                    break;
                case "tabs":
                    this.addTabs(node, element);
                    break;
                case "grid":
                    this.addGrid(node, element);
                    break;
                case "text":
                    this.addInput(node, 'yic-form-text-input', element)
                    break;
                case "textarea":
                    this.addInput(node, 'yic-form-textarea-input', element)
                    break;
                case "json":
                    this.addInput(node, 'yic-form-json-input', element)
                    break;
                case "id":
                case "number":
                    this.addInput(node, 'yic-form-number-input', element)
                    break;
            }
        });
    }

    addGrid(node, element) {
        let gridcontainer = document.createElement('yic-grid');
        gridcontainer.setAttribute("count", element.count);
        element.elements.forEach((grid)=>{
            let gridElement = gridcontainer.addGridElement();
            this.addElements( grid.elements, gridElement );
        });
        node.appendChild(gridcontainer);
    }

    addTabs(node, element) {
        let tabs = document.createElement('yic-tabs');
        element.elements.forEach((tab)=>{
            let content = document.createElement('div');
            this.addElements( tab.elements, content );
            tabs.addTab( tab.label, content );
        });
        node.appendChild(tabs);
    }

    addHidden(node, element) {
        let input = document.createElement('input');
        input.type = "hidden";
        let value = this.datamodel.getValue(element.datapath, true);
        if (value !== undefined) input.setAttribute('value', value);
        node.appendChild(input);
    }

    addInput(node, inputelement, element){
        let div = document.createElement('div');
        let input = document.createElement(inputelement);
        if (element.label) input.setAttribute('label', element.label);
        if (element.name) input.setAttribute('name', element.name);
        let value = this.datamodel.getValue(element.datapath, true);
        if (value !== undefined) input.setAttribute('value', value);

        // Register the input with the datamodel
        // This is helpfull if value in datamodel is changed by other agents

        this.datamodel.registerListener( element.datapath, input );
        // Add a callback function to respond to changes in the datamodel
        // Add a listener to respond to input changes and notify the datamodel
        
        input.addEventListener('change', (ev) =>{
            let value = ev.detail.value;
            console.log(value);
            this.datamodel.setValue(element.datapath, value);
        })
        input.onChange = (datapath, value) => {
            if (input.getAttribute('value') != value) {
                input.setAttribute('value', value);
            }
        };
        input.onError = (datapath, errors) => {
            input.errors = errors;
            input.refreshErrors();
        }
        div.appendChild(input);
        node.appendChild(div);
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