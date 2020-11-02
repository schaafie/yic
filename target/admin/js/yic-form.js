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

export default class YicForm extends HTMLElement {
        constructor() {
        super();
        this.definition = { elements: [], action: "", name: "" };
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$form = this._shadowRoot.querySelector('#yic-form');
        this.$title = this._shadowRoot.querySelector('h2');
    }

    connectedCallback() {

    }

    setDefinition(definition) {
        this.definition = definition;
        this._populateForm();
    }

    _populateForm() {
        var count = 0;
        this.$title.innerHTML = this.definition.title;
        this.definition.elements.forEach(element => {
            count++;
            switch(element.type) {
                case "text":
                    var input = document.createElement("yic-form-text-input");
                    input.setAttribute('name', element.name);
                    input.setAttribute('count', count);
                    input.setAttribute('label', element.label);
                    input.setAttribute('required', element.required);
                    this.$form.appendChild(input)
                    break;
                case "email":
                    var input = document.createElement("yic-form-email-input");
                    input.setAttribute('name', element.name);
                    input.setAttribute('count', count);
                    input.setAttribute('label', element.label);
                    input.setAttribute('required', element.required);
                    this.$form.appendChild(input)
                    break;
            }});

        // Place submit button
        var button = document.createElement("yic-form-submit");
        this.$form.appendChild(button)
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