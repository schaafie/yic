const template = document.createElement('template');
template.innerHTML = `
    <style>
    :host {
        color: #333333;
        font: 16px Arial, sans-serif;    
    }

    button[aria-selected="true"] {
        border-bottom: 2px solid blue;
    }

    </style>
    <h2 id="groupsheader"></h2>
    <div id="yicgroups" role="list">
    </div>
    <yic-form-action id="addgroupitem"></yic-form-action>
`;

const grouptemplate = document.createElement('template');
grouptemplate.innerHTML = `
    <style>
    .actionbutton { 
        cursor: pointer; 
    }
    </style>
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined">
    <div id="" class="listitem" role="listitem">
        <h2 class="itemheader"></h2>
        <button class="actionbutton"><i class="material-icons-outlined">Delete</i>&nbsp;Delete</button>
        <div class="itemcontent"></div>
    </div>
`;

export default class YicGroups extends HTMLElement {

    constructor() {
        super();
        this.attachShadow({mode: 'open'});
        this.shadowRoot.appendChild(template.content.cloneNode(true));
        this.groups = this.shadowRoot.querySelector('#yicgroups');
        this.shadowRoot.querySelector('#addgroupitem').addEventListener((e) => {
            this.dispatchEvent(new CustomEvent('add',{ detail: {}, bubbles: false }));
        })
    }

    connectedCallback() {}

    disconnectedCallback() {}

    addGroup( id, itemheader ) {
        let group = grouptemplate.content.cloneNode(true);
        group.querySelector(".listitem").id = id;
        group.querySelector(".itemheader").innerHTML = itemheader;
        this.groups.appendChild(group);
    }

    setGroupContent( id, content ) {
        this.shadowRoot.querySelector(`#${id}>div.itemcontent`).appendChild(content);
    }

    deleteGroup( id ) {
        let node = this.shadowRoot.querySelector(`#${id}>div.itemcontent`);
        this.shadowRoot.querySelector(`#${id}`).removeChild(node);
        this.dispatchEvent(new CustomEvent('delete',{ detail: {groupid: id}, bubbles: false }));
    }

    static get observedAttributes() { 
        return ['label', 'actionlabel'];
    }

    attributeChangedCallback(name, oldValue, newValue) {
        switch(name) {
            case 'label':
                this.shadowRoot.querySelector('#groupsheader').innerHTML = newValue;
                break;
            case 'actionlabel':
                this.shadowRoot.querySelector('#addgroupitem').innerHTML = newValue;
        }
    }


}

customElements.define('yic-groups', YicGroups);