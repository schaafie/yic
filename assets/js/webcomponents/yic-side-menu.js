const template = document.createElement('template');
template.innerHTML = `<style>
:host {
    color: #333333;
    font: 16px Arial, sans-serif;
}

#context-menu-bar a {
    padding: 14px 16px;
    text-decoration: none;
    display: block;
    color: #333;
}

#context-menu-bar a:hover {
    color: black;
}

</style>
<div id="context-menu-bar">
    <p>
    </p>
</div>
`;

export default class YicSideMenu extends HTMLElement {
    constructor() {
        super();
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$menulist = this._shadowRoot.querySelector('#context-menu-bar p');
    }

    connectedCallback() {

    }

    setMenu(list) {
        list.forEach(item => {
            var link = document.createElement('a');
            if (item.id) link.id = item.id
            if (item.url) link.setAttribute( 'href', item.url );
            if (item.callback) link.onclick = item.callback;
            link.innerHTML = item.title;
            this.$menulist.appendChild( link );
        });
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

window.customElements.define('yic-side-menu', YicSideMenu);