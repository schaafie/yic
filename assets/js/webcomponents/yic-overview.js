const template = document.createElement('template');
template.innerHTML = `<style>
:host {
    color: #333333;
    font: 16px Arial, sans-serif;
}

h2 {
    margin: 50px 50px 0px;
    padding: 20px 50px;
    max-width:1200px;
    border-bottom: 2px solid #ccc;
}

.container {
    margin: 0px 50px 50px;
    padding: 20px 50px;
    max-width:1200px;
}

table {
    border-collapse: collapse;
    min-width: 400px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
}

table thead tr {
    background-color: #009879;
    color: #ffffff;
    text-align: left;
}

table th,
table td {
    padding: 12px 15px;
}

tbody tr {
    border-bottom: 1px solid #dddddd;
}

tbody tr:nth-of-type(even) {
    background-color: #f3f3f3;
}

tbody tr:last-of-type {
    border-bottom: 2px solid #009879;
}

</style>
<h2></h2>
<div class="container">
    <div id="yic-overview"></div>
    <table>
        <thead>
        </thead>
        <tbody>
        </tbody>
        <tfoot>
        </tfoot>
    </table>
</div>
`;

export default class YicOverview extends HTMLElement {
    
    constructor() {
        super();
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$children = this._shadowRoot.querySelector('#yic-overview');
        this.$title = this._shadowRoot.querySelector('h2');
        this.$header = this._shadowRoot.querySelector('thead');
        this.$body = this._shadowRoot.querySelector('tbody');
    }

    connectedCallback() {}
    

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

window.customElements.define('yic-overview', YicOverview);