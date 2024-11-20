import wcconfig from "./wcconfig.json";

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

        // Add debug element
        let debug = document.createElement('yic-form-debug');
        debug.setModel( this.datamodel );
        div.appendChild( debug );

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
                case "groups":
                    this.addGroups(node, element);
                    break;
                default:
                    this.addInput(node, element);
                    break;
            }
        });
    }

    addGroup() {
        let groups = document.createElement('yic-groups');
        groups.setAttribute("label", element.label);
        groups.setAttribute("actionlabel", element.actionlabel);
        // Add listener for new group event
        // Listen for custom add event
        groups.addEventListener('add', (ev) => {

        });
        // Listen for custom delete event
        groups.addEventListener('delete', (ev) => {

        });
        element.elements.forEach((group) => {
            
        });
        node.appendChild(groups);
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

    addInput(node, element){
        let config = wcconfig[element.type];
        let div = document.createElement('div');
        let input = document.createElement( config.component );
        if (element.label) input.setAttribute('label', element.label);
        if (element.name) input.setAttribute('name', element.name);
        let itemlist = [];

        config.values.forEach( valueItem => {
            let path = (valueItem.path=="")?element.datapath:`${element.datapath}/${valueItem.path}`;
            let value = this.datamodel.getValue(path);
            let type =  typeof(value);
            let name = valueItem.name;
            itemlist.push({ name: name, type: type, value: value, path: path});

            switch(valueItem.method ) {
                case "attr":
                    if (value !== undefined && type == "object") {
                        let str_value = JSON.stringify(value, null, "  ");
                        input.setAttribute(valueItem.name, str_value);
                    } else if (value !== undefined) {
                        input.setAttribute(valueItem.name, value);
                    }
                    
                    // Register the input with the datamodel
                    // This is helpfull if value in datamodel is changed by other agents
                    this.datamodel.registerListener( path, input );
                    
                    // Add a listener to respond to input changes and notify the datamodel
                    input.onChange = (path, value) => {
                        if (input.getAttribute(valueItem.name) != value) {
                            input.setAttribute(valueItem.name, value);
                        }
                    };
                    
                    input.onError = ( path, errors ) => {
                        input.errors = errors;
                        input.refreshErrors();
                    }

                    break;

                case "data":
                    if (value !== undefined) input.setData(valueItem.name, value);
                    
                    // Register the input with the datamodel
                    // This is helpfull if value in datamodel is changed by other agents
                    this.datamodel.registerListener( path, input );

                    // Add a listener to respond to input changes and notify the datamodel
                    input.onChange = (path, value) => {
                        if (input.getData(valueItem.name) != value) {
                            input.setData(valueItem.name, value);
                        }
                    };
                    
                    input.onError = (datapath, errors) => {
                        input.errors = errors;
                        input.refreshErrors();
                    }
                    break;
            }
        });

        // Add a callback function to respond to changes in the datamodel        
        input.addEventListener('change', (ev) => {
            for (const [key, value] of Object.entries(ev.detail)) {
                let item = itemlist.find(({ name }) => name === key);
                this.datamodel.setValue(item.path, value);                    
            }
        });

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