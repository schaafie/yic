const topMenuTemplate = document.createElement('template');
topMenuTemplate.innerHTML = `<style>
:host {
    color: #333;
    font: 16px Arial, sans-serif;
}

.nav-wrapper {
    width: 100%;
    padding: 5px 2px;
    border-radius: 4px;
    background: #eaeaea;
    border: 1px solid grey;
}

ul {
    padding: 0;
    margin: 4px;
}

li {
    display: inline;
    padding: 5px 10px;
    margin-right: 2px;
    position: relative;
    background: cornflowerblue;
    color: white;
    font: 14pt arial, sans-serif;
    border-radius: 4px;
    cursor: grab;
}

li.right {
    float: right;
    margin-top: -5px;
    margin-right: -2px;
}

li:hover ul {
    display: block;
}

ul ul {
    position: absolute;
    display: none;
    left: -5px;
    top: 100%;
}

</style>
<div id="top-menu-bar" class="nav-wrapper">
   <nav class="nav-menu">
      <ul class="clearfix">
      </ul>
   </nav>
</div>
`;

export default class YicTopMenu extends HTMLElement {
    
    constructor() {
        super();
        this.logoutSet = false;
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild( topMenuTemplate.content.cloneNode(true) );
        this.$topmenu = this._shadowRoot.querySelector('.clearfix');
    }

    connectedCallback() {}

    setMenu(list) {
        list.forEach(item => { this.setMenuItem( this.$topmenu, item ); });
    }
    
    setMenuItem( parent, item) {
        let li = document.createElement('li');
        let link = document.createElement('a');
        // Set attributes
        if (item.type == 'dropdown') {
            if (item.id) link.id = item.id
            if (item.title) link.innerHTML = item.title;
            if (item.align == "right") li.classList.add("right");
            let ul = document.createElement('ul');
            ul.classList.add("sub-menu");
            item.items.forEach(subitem => {
                this.setMenuItem(ul, subitem);
            });
            li.appendChild(link);
            li.appendChild(ul);
            parent.appendChild(li);
        } else {
            if (item.id) link.id = item.id
            if (item.title) link.innerHTML = item.title;
            if (item.url) link.setAttribute( 'href', item.url );
            if (item.callback) link.onclick = item.callback;    
            li.appendChild(link);
            parent.appendChild( li );
        }
    }

    addLogout(item) {
        if (!this.logoutSet) {
            this.setMenuItem(item);
            this.logoutSet = true;
        }
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