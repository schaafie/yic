const template = document.createElement('template');
template.innerHTML = `<style>
:host {
    color: #333333;
    font: 16px Arial, sans-serif;
}

.panel {
    border:solid cornflowerblue 2px;
    border-radius: 10px;
    margin: 20px;
}

.panel-head {
    background-color: cornflowerblue;
    color: white;
    font: 24px Arial, sans-serif;
    padding: 10px;
}

.panel-body {
    background-color: white;
    padding: 20px;
}
</style>
<div id="#yic-panel" class="panel">
    <div id="title" class="panel-head"></div>
    <div id="content" class="panel-body"></div>
</div>
`;

export default class YicPanel extends HTMLElement {
    
    constructor() {
        super();
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$title = this._shadowRoot.querySelector('#title');
        this.$content = this._shadowRoot.querySelector('#content');
    }

    connectedCallback() {}

    set panelbody(content) { 
        if (typeof(content) == "string" ) {
            this.$content.innerHTML = content; 
        } else {
            this.$content.appendChild(content); 
        }
    }
        
    static get observedAttributes() { 
        return ['title'];
    }

    attributeChangedCallback(name, oldValue, newValue) {
        switch(name) {
            case 'title':
                this.$title.innerHTML = newValue;
                break;
        }
    }
}

window.customElements.define('yic-panel', YicPanel);