const template = document.createElement('template');
template.innerHTML = `<style>
:host {
    color: #333333;
    font: 16px Arial, sans-serif;
}

#top-menu-bar {
    background-color: #eee;
    border-top: 2px outset #aaa;
    border-bottom: 2px inset #aaa;
    overflow: hidden;
}
  
/* Navbar links */
#top-menu-bar a {
    float: left;
    display: block;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
    color: #333333;
}

#top-menu-bar a:hover {
    color: black;
}
</style>
<div id="top-menu-bar">
</div>`;

export default class YicTopMenu extends HTMLElement {
        constructor() {
        super();
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));
        this.$topmenu = this._shadowRoot.querySelector('#top-menu-bar');
    }

    connectedCallback() {

    }

    setMenu(list) {
        list.forEach(item => {
            var link = document.createElement('a');
            link.setAttribute( 'href', item.url );
            link.innerHTML = item.title;
            this.$topmenu.appendChild( link );
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

window.customElements.define('yic-top-menu', YicTopMenu);