const topMenuTemplate = document.createElement('template');
topMenuTemplate.innerHTML = `<style>
:host {
    color: #333;
    font: 16px Arial, sans-serif;
}

.nav-wrapper {
    width: 100%;
    padding: 5px 2px;
    background-color: cornflowerblue;
    color: white;
    font: bold;
}

#menu {
    width: 100%;
    margin: 0;
    padding: 10px 0 0 0;
    list-style: none;
}

#menu li {
    float: left;
    padding: 0 0 10px 0;
    position: relative;
}

#menu a {
    float: left;
    height: 25px;
    padding: 0 25px;
    text-decoration: none;
    cursor: pointer;
}

#menu li:hover > a {
    color: #fafafa;
}

#menu li:hover > ul {
    display: block;
}

/* Sub-menu */
#menu ul {
    list-style: none;
    margin: 0;
    padding: 0;
    display: none;
    position: absolute;
    top: 35px;
    left: 0;
    z-index: 99999;
    background-color: cornflowerblue;
}

#menu ul li {
    float: none;
    margin: 0;
    padding: 0;
    display: block;
}

#menu ul li:last-child {
    box-shadow: none;
}

#menu ul a {
    padding: 10px;
    height: auto;
    line-height: 1;
    display: block;
    white-space: nowrap;
    float: none;
    text-transform: none;
}

#menu ul a:hover {
    background-color: #0186ba;
}

#menu ul li:first-child a:after {
    content: '';
    position: absolute;
    left: 30px;
    top: -8px;
    width: 0;
    height: 0;
    border-left: 5px solid transparent;
    border-right: 5px solid transparent;
    border-bottom: 8px solid #444;
}

#menu ul li:first-child a:hover:after {
    border-bottom-color: #04acec;
}

#menu ul li:last-child a {
    border-radius: 0 0 5px 5px;
}

/* Clear floated elements */
#menu:after {
    visibility: hidden;
    display: block;
    font-size: 0;
    content: " ";
    clear: both;
    height: 0;
}

li.right {
    float: right;
}

</style>
<div class="nav-wrapper">
    <ul id="menu">
    </ul>
</div>
`;

export default class YicTopMenu extends HTMLElement {
    
    constructor() {
        super();
        this.logoutSet = false;
        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild( topMenuTemplate.content.cloneNode(true) );
        this.$topmenu = this._shadowRoot.querySelector('#menu');
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