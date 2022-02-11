const topMenuTemplate = `<style>
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
    padding: 10px;
    text-decoration: none;
    color: #3333ff;
}

#top-menu-bar a.logout {
    float: right;
}

#top-menu-bar a:hover {
    color: black;
    cursor: pointer;
    
}
</style>
<div id="top-menu-bar">
</div>`;

export default class YicTopMenu extends HTMLElement {
    
    constructor() {
        super();
        this.logoutSet = false;
        this.innerHTML = topMenuTemplate;
        this.$topmenu = this.querySelector('#top-menu-bar');
    }

    connectedCallback() {}

    setMenu(list, apppage ) {
        this.$apppage = apppage;
        list.forEach(item => {
            this.setMenuItem(item);
        });
    }
    
    setMenuItem(item) {
        var link = document.createElement('a');
        // Set attributes
        if (item.id) link.id = item.id
        if (item.title) link.innerHTML = item.title;
        // Set action depending on definition
        if (item.json) link.addEventListener( 'click', () => { this.$apppage.initApp(item.json)});
        if (item.url) link.setAttribute( 'href', item.url );
        if (item.callback) link.onclick = item.callback;
        // Check for special types
        if (item.type) {
            link.classList.add("logout");
            link.innerHTML = "Logout";
        }

        this.$topmenu.appendChild( link );
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