const appPageTemplate = `
<div>
    <yic-side-menu></yic-side-menu>
    <div id="app-page">No (valid) application selected</div>
</div>
`;

export default class YicAppPage extends HTMLElement {
    
    constructor() {
        super();
        this.innerHTML = appPageTemplate;
        this.$app = this.querySelector("#app-page");
        this.$sidebar = this.querySelector("yic-side-menu");    
    }

    initApp( jsonCmd ) {
        var token = document.querySelector('yic-auth').getToken();
        var options = { 
            headers: { 
                'Authorization': `Bearer ${token}`, 
                'Content-Type': 'application/json' 
            }
        };
        fetch( `http://localhost:4000/api/${jsonCmd}`, options ).then( response => {
            return response.json();
        }).then( data => {
            var def = data.data;
            // this.setMenu( def.menu );
            this.setContent( def.formdef, def.data, def.datadef);
        });
    }

    // setMenu(menuDef) {
    //     if (menuDef.contextMenu.length == 0) {
    //         document.querySelector("#content").classList.remove("extended");
    //         document.querySelector("#content").classList.add("collapsed");
    //     } else {
    //         document.querySelector("yic-side-menu").setMenu( menuDef.contextMenu );
    //         document.querySelector("#content").classList.remove("collapsed");
    //         document.querySelector("#content").classList.add("extended");
    //     }
    // }

    setContent(pageelement, data, datadef) {
        switch(pageelement.definition.type) {
            case "overview":
                var overview = document.createElement("yic-overview");
                overview.setDataVault( data, datadef );
                overview.setDefinition( pageelement );
                overview.populate();        
                document.querySelector("#main-content").appendChild(overview);
                break;
            case "detail":
                var form = document.createElement("yic-form");
                form.setDataVault( data, datadef );
                form.setDefinition( pageelement );
                form.populateForm();        
                document.querySelector("#main-content").appendChild(form);
                break;
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

window.customElements.define('yic-app-page', YicAppPage);