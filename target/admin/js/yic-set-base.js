export default class YicSetBase extends HTMLElement {

    constructor() {
        super();
        this.definition = {};
        this.elementcounter = 0;
        this.webcomponents = [
            { type: "text", webcomponent: "yic-form-text-input" },
            { type: "email", webcomponent: "yic-form-email-input" },
            { type: "rows", webcomponent: "yic-form-rows" },
            { type: "row", webcomponent: "yic-form-row" },
            { type: "definition", webcomponent: "yic-form-definition" }
        ];
    }

    connectedCallback() { }

    addChildren( children, childlocation, parent ) {
        this.populate( children, childlocation, parent );
    }

    setCounter(count) {
        this.elementcounter = count;
    }

    getCounter() {
        return this.elementcounter;
    }

    setParent(parent) {
        console.log(parent);
        this.parent = parent;
    }

    populateElements(element) {
        this.definition = element;
    }

    populate(elements, contentLocation, parent) {
        this.setParent( parent );
        elements.forEach(element => {
            this.elementcounter++;
            this.webcomponents.forEach(option => {
                if (element.type == option.type) {
                    var component = document.createElement(option.webcomponent);
                    component.setCounter(this.elementcounter);
                    // Handle attributes
                    component.populateElements(element);
                    // Handle children
                    if (element.elements) {
                        this.addChildren(element.elements, component.$children, this);
                    }
                    contentLocation.appendChild(component);
                    this.elementcounter = component.getCounter();
                }
            });
        });
    }

    static get observedAttributes() {
        return ['value'];
    }

    attributeChangedCallback(name, oldValue, newValue) {
        switch (name) {
            case 'value':
                if (this.value != newValue) {
                    this.value = newValue;
                }
                break;
        }
    }
}

window.customElements.define('yic-set-base', YicSetBase);