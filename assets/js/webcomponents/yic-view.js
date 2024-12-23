import YicDatamodel from "../yic-datamodel.js";
import YicAuth from "../yic-auth.js";
import YicController from '../yic-controller.js';

const appPageTemplate = `<div>
    <yic-top-menu></yic-top-menu>
    <yic-panel title=""></yic-panel>
</div>`;

const appPageDebugTemplate = `<div>
    <yic-top-menu></yic-top-menu>
    <yic-grid count=2>
        <yic-panel title="Debug">
            <yic-form-debug></yic-form-debug>
        </yic-panel>
    </yic-grid>
    <yic-grid count=2>
        <yic-panel title=""></yic-panel>
    </yic-grid>
</div>`;


const errorPageTemplate = `<div>
    <yic-top-menu></yic-top-menu>
    <h1>Error</h1>
    <div id="error"></div>
</div>`;

const indexPageTemplate = `<div>
    <yic-top-menu></yic-top-menu>
    <yic-panel title="Welcome"></yic-panel>
</div>`;


const loginTemplate = `
<div class="appcontainer">
    <div class="innercontainer">
        <h2>Login</h2>
        <div id="errortxt"></div>
        <p>
            <yic-form-text-input label="User name"></yic-form-text-input>
            <yic-form-password-input label="Password"></yic-form-password-input>
            <yic-form-action label="login"></yic-form-action>
        </p>
    </div>
</div>`;

export default class YicView extends HTMLElement {
    
    constructor() {
        super();
        this.currentapp = "home";
    }

    connectedCallback() {
        this.auth = new YicAuth();
        this.model = new YicDatamodel( this.auth );
        this.app = new YicController( this.model, this.auth );

        if (!this.auth.isLoggedIn()) {
            this.showPage("login");
        } else {
            this.showApp();
            this.app.loadApps();
        }
    }

    showPage( page, opts = {} ) {
        switch(page) {
            case "login":
                this.innerHTML = loginTemplate;
                if (opts.message) this.querySelector("#errortxt").innerHTML = opts.message;
                this.querySelector("yic-form-action").addEventListener('click', () => {
                    let login = this.querySelector("yic-form-text-input").getAttribute("Value");
                    let password = this.querySelector("yic-form-password-input").getAttribute("value");
                    this.app.doAuth( login, password );
                });
                break;
            case "error":
                this.innerHTML = errorPageTemplate;
                this.querySelector("yic-top-menu").setMenu( opts.topmenu );
                this.querySelector("#error").innerHTML = opts.msg;
                break;
            case "index":
                this.innerHTML = indexPageTemplate;
                this.querySelector("yic-top-menu").setMenu( opts.topmenu );
                this.querySelector("yic-panel").panelbody = `Please select an app in the menu.`;
                break;
            case "app":
                this.innerHTML = appPageTemplate;
                this.querySelector("yic-top-menu").setMenu( opts.topmenu );
                this.setContent( opts.form, opts.datamodel );
                break;
        }
    }

    setContent(formdef, datamodel ) {
        switch(formdef.type) {
            case "overview":
                let overview = document.createElement("yic-overview");
                overview.init(this.app, datamodel, formdef );
                overview.populate();
                document.querySelector("yic-panel").setAttribute("title", formdef.title);
                document.querySelector("yic-panel").panelbody = overview;
                break;
            case "detail":
                let form = document.createElement("yic-form");
                form.init(this.app, datamodel, formdef );
                form.populate();
                document.querySelector("yic-panel").setAttribute("title", formdef.title);
                document.querySelector("yic-panel").panelbody = form;
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

window.customElements.define('yic-view', YicView);