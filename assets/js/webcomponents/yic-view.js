import YicDatamodel from "../yic-datamodel.js";
import YicAuth from "../yic-auth.js";
import YicController from '../yic-controller.js';

const appPageTemplate = `<div class="container">
    <yic-top-menu></yic-top-menu>
    <div id="app-page"></div>
</div>`;

const errorPageTemplate = `<div class="container">
    <yic-top-menu></yic-top-menu>
    <h1>Error</h1>
    <div id="error"></div>
</div>`;

const indexPageTemplate = `<div class="container">
    <yic-top-menu></yic-top-menu>
    <h1>Welcome</h1>
    <div>Please select an app in the menu.</div>
</div>`;


const loginTemplate = `<div class="container">
    <h2>Login</h2>
    <p>
        <yic-form-text-input label="login"></yic-form-text-input>
        <yic-form-password-input label="password"></yic-form-password-input>
        <yic-form-action label="login"></yic-form-action>
    </p>
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
                this.querySelector("yic-form-action").addEventListener('click', () => {
                    let login = this.querySelector("yic-form-text-input").getAttribute("Value");
                    let password = this.querySelector("yic-form-password-input").getAttribute("value");
                    this.app.doAuth( login, password );
                });
                break;
            case "error":
                this.innerHTML = errorPageTemplate;
                this.querySelector("#error").innerHTML = opts.msg;
                this.querySelector("yic-top-menu").setMenu( opts.topmenu );
                break;
            case "index":
                this.innerHTML = indexPageTemplate;
                this.querySelector("yic-top-menu").setMenu( opts.topmenu );
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
                document.querySelector("#app-page").appendChild(overview);
                break;
            case "detail":
                let form = document.createElement("yic-form");
                form.init(this.app, datamodel, formdef );
                form.populate();
                document.querySelector("#app-page").appendChild(form);
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