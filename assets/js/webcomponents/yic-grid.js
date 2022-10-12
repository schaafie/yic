const template = document.createElement('template');
template.innerHTML = `<style>
:host {
    color: #333333;
    font: 16px Arial, sans-serif;
}

.grid {
    margin: 20px;
    width: 100%;
    display: inline;
}

.grid-25 {
    padding: 10px;
    width: 20%;
    display: inline-grid;
}

.grid-33 {
    padding: 15px;
    width: 30%;
    display: inline-grid;
}

.grid-50 {
    padding: 20px;
    width: 40%;
    display: inline-grid;
}

</style>
<div id="yic-grid" class="grid"></div>
`;

export default class YicGrid extends HTMLElement {
    
    constructor() {
        super();
        this.grids = 0;
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$grid = this._shadowRoot.querySelector('#yic-grid');
    }

    connectedCallback() {}

    addGridElement() { 
        let element = document.createElement('div');
        switch(this.grids) {
            case "2":
                element.className = "grid-50";
                break;
            case "3":
                element.className = "grid-33";
                break;
            case "4":
                element.className = "grid-25";
                break;
        }
        this.$grid.appendChild(element);
        return element;
    }
        
    static get observedAttributes() { 
        return ['count'];
    }

    attributeChangedCallback(name, oldValue, newValue) {
        switch(name) {
            case 'count':
                this.grids = newValue;
                break;
        }
    }
}

window.customElements.define('yic-grid', YicGrid);