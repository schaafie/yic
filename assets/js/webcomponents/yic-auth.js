const loginTemplate = `<div class="container">
    <h2>Login</h2>
    <p>
        <yic-form-text-input label="login"></yic-form-text-input>
        <yic-form-password-input label="password"></yic-form-password-input>
        <yic-form-action label="login"></yic-form-action>
    </p>
</div>`;

export default class YicAuth extends HTMLElement {
    
    constructor() {
        super();
        this.jwt = "";
        this.authContent = this.innerHTML;
        this.render();
    }

    render() {
        if (this.jwt == "") {
            this.innerHTML = loginTemplate;
            this.querySelector("yic-form-action").onclick = this.doLogin.bind(this);
        } else {
            this.innerHTML = this.authContent;
            var appnav = this.querySelector('yic-app-nav');
            appnav.addLogout({id: "logout" , callback: this.doLogout.bind(this), type: "logout"});
        }
    }

    getToken() { return this.jwt; }

    doLogout() { 
        this.jwt = ""; 
        this.render();
    }
    
    doLogin() {
        var xhr = new XMLHttpRequest();
        var data = {};

        data.login = this.querySelector("yic-form-text-input").getAttribute("Value");
        data.password = this.querySelector("yic-form-password-input").getAttribute("value");

        xhr.open('POST', 'http://localhost:4000/api/sign_in', true);
        // MUST HAVE! JSON content-type
        xhr.setRequestHeader('Content-Type', 'application/json');        
        // Define followup actions. 
        var that = this;
        xhr.onreadystatechange = function () {
            if(xhr.readyState === XMLHttpRequest.DONE) {
                var status = xhr.status;
                if (status === 0 || (status >= 200 && status < 400)) {
                    that.handleSucces( xhr.responseText );
                } else {
                    that.handleError( xhr.responseText );
                }
            }
        }
        xhr.send(JSON.stringify( data ));
    }

    handleError( txt ) {
        console.log( "Error: " + txt );
        var errObject = JSON.parse( txt );

    }

    handleSucces( txt ) {
        console.log( "Succes: " + txt );
        var jsonObject = JSON.parse(txt);
        this.jwt = jsonObject.data.token;
        this.render();
    }

    static get observedAttributes() { 
        return [];
    }

    connectedCallback() {}

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

window.customElements.define('yic-auth', YicAuth);