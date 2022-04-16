const appNavTemplate = `
<div class="container">
    <yic-top-menu></yic-top-menu>
    <yic-app-page></yic-app-page>
</div>
`;

export default class YicAppNav extends HTMLElement {
    
    constructor() {
        super();
        this.path = "/json/apps.json";
        this.innerHTML = appNavTemplate;
        this.$topmenu = this.querySelector('yic-top-menu');
        this.$apppage = this.querySelector('yic-app-page');
        var token = document.querySelector('yic-auth').getToken();
        var options = { 
            Authorization: `Bearer ${token}`,
            header: { 'Content-Type': 'application/json' }
        }
        fetch( this.path, options ).then( response => {
            return response.json();
        }).then( data => {
            var apps = data.apps;
            this.$topmenu.setMenu( apps, this.$apppage );
        });
    }

    connectedCallback() {}

    addLogout(item) {
        this.$topmenu.addLogout(item);
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

window.customElements.define('yic-app-nav', YicAppNav);