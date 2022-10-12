const template = document.createElement('template');
template.innerHTML = `
    <style>
    :host {
        color: #333333;
        font: 16px Arial, sans-serif;    
    }

    #tab-bar {
        margin-bottom: 10px;
    }

    #tab-content {
        margin-top: 20px;
    }

    .tab {
        border: none;
        background-color: white;
        font-size: 1.5em;
        font-weight: bold;
        padding-right: 40px;
        padding-bottom: 10px;
        cursor: hand;
    }

    button[aria-selected="true"] {
        border-bottom: 2px solid blue;
    }

    </style>
    <div id="tab-bar" role="tablist" aria=label="form tabs"></div>
    <div id="tab-content"></div>
`;

export default class YicTabs extends HTMLElement {

    constructor() {
        super();
        this.tabregister = [];
        this.tabcount = 0;
        this.selected_tab = "";
        this.attachShadow({mode: 'open'});
        this.shadowRoot.appendChild(template.content.cloneNode(true));
        this.tabs = this.shadowRoot.querySelector('#tab-bar');
        this.tabpanels = this.shadowRoot.querySelector('#tab-content');
    }

    connectedCallback() {}

    disconnectedCallback() {}

    addTab( label, content ) {
        this.tabcount++;
        let tab_id  = `yt_tab_${this.tabcount}`;
        let tp_id   = `yic_tabpanel_${this.tabcount}`;
        this.tabregister.push({ order:this.tabcount, tab: tab_id, panel: tp_id});

        let tab = document.createElement('button');
        tab.setAttribute("id", tab_id);
        tab.className = "tab";
        tab.setAttribute('role', 'tab');
        if (this.tabcount==1) {
            tab.setAttribute("tab_index", "0");
            tab.setAttribute('aria-selected', "true");
        } else {
            tab.setAttribute("tab_index", "-1");
            tab.setAttribute('aria-selected', "false");
        }
        tab.setAttribute('aria-controls', tp_id);
        tab.innerHTML = label;
        tab.addEventListener('click', (e) => { this.tab_click(e) });
        this.tabs.appendChild(tab);

        let tabpanel = document.createElement('div');
        tabpanel.setAttribute("id", tp_id);
        tabpanel.setAttribute('role', 'tabpanel');
        tabpanel.setAttribute("tabindex", "0");
        tabpanel.setAttribute("labelledby", tab_id);
        tabpanel.appendChild( content );
        if (this.tabcount!=1) tabpanel.hidden = true;
        this.tabpanels.appendChild(tabpanel);
    }

    tab_click(e) {
        this.tabregister.forEach( (regtab)=>{
            let tab = this.tabs.querySelector(`#${regtab.tab}`);
            let panel = this.tabpanels.querySelector(`#${regtab.panel}`);
            if (regtab.tab == e.target.id) {
                tab.setAttribute("aria-selected", "true");
                panel.hidden = false;
            } else {
                tab.setAttribute("aria-selected", "false");
                panel.hidden = true;   
            }
        })
    }

}

customElements.define('yic-tabs', YicTabs);