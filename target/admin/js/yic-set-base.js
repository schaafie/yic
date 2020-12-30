export default class YicSetBase extends HTMLElement {

    constructor() {
        super();
        this.definition = {};
        this.datavault = {};
        this.parent = {};
        // this.internalId = "";
        // this.name = "";
        this.elementcounter = 0;
        this.webcomponents = [
            { type: "text", webcomponent: "yic-form-text-input" },
            { type: "email", webcomponent: "yic-form-email-input" },
            { type: "rows", webcomponent: "yic-form-rows" },
            { type: "row", webcomponent: "yic-form-row" },
            { type: "definition", webcomponent: "yic-form-definition" }
        ];
    }

    connectedCallback() {}
    static get observedAttributes() { return []; }
    attributeChangedCallback(name, oldValue, newValue) {}

    setCounter(count) {
        this.elementcounter = count;
    }

    getCounter() {
        return this.elementcounter;
    }

    // Handle attributes of element
    populateElements(element) {
        this.definition = element;
    }

    // Handle elements attribute of element
    populate(elements, datavault, contentLocation) {
        this.datavault = datavault;
        var me = this;
        // this.setInternalId();
        elements.forEach(element => {
            if (this.dataVault.hasElement( element.datapath )) {
                this.elementcounter++;
                this.webcomponents.forEach(option => {
                    if (element.type == option.type) {
                        var component = document.createElement(option.webcomponent);
                        component.datavault = datavault;
                        component.parent = me;
                        component.setCounter(this.elementcounter);
                        // Handle attributes
                        component.populateElements(element);
                        // Handle children
                        if (element.type == "rows") {
                            var items = this.dataVault.getSetItems( element.datapath );
                            
                        }
                        else if (element.elements) {
                            component.populate(element.elements, datavault, component.$children);
                        }
                        contentLocation.appendChild(component);
                        this.elementcounter = component.getCounter();
                    }
                });    
            }
        });
    }
}

window.customElements.define('yic-set-base', YicSetBase);