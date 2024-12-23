import YicDatamodel from "./yic-datamodel";
import YicConf from "./yic-conf";

export default class YicController {

    constructor( datamodel, auth ) {
        this.model = datamodel;
        this.auth = auth;
        this.auth.register(this);
        this.view = document.querySelector("yic-view");
        this.authChanged();
    }

    authChanged() {
        if (!this.auth.isLoggedIn()) {
            this.view.showPage("login");
        } else {
            this.loadApps();
        }
    }

    authFailed( errorObject ) {
        this.view.showPage("login", { message: errorObject.message });
    }
    
    loadApps() {
        this.apps = [];
        let thisapp = this;
        this.path = "/json/apps.json";
        fetch( this.path, this.getCallOptions() ).then( response => {
            return response.json();
        }).then( data => {
            data.apps.forEach( (app) => {
                if (app.type=="dropdown") {
                    app.items.forEach( (item) => {
                        item.callback = function() { thisapp.doCommand(item.json); };    
                    });
                } else {
                    app.callback = function() { thisapp.doCommand(app.json); };
                }
                this.apps.push(app);
            });
            this.apps.push( { title: this.auth.getLoggedInUser(), type: 'dropdown', align: "right", items: [{title: "logout", type: "link", callback: () => { this.auth.doLogout(); }}] } );
            this.view.showPage("index", {topmenu: this.apps});
        });
    }

    doAuth( user, password ) {
        this.auth.doLogin( user, password);
    }

    doCommand( jsonCmd ) { 
        fetch( YicConf.baseUrl()+jsonCmd, { method: "GET", headers: this.getCallOptions() })
            .then( response => {
                if (!response.ok) {
                    switch(response.status) {
                        case 401:
                        case 403:
                            this.view.showPage("login", {msg: response.statusText});
                            break;
                        default:
                            console.log(response);
                            throw Error(response.statusText);
                    }
                } else {
                    return response.json();
                }
            }).then( json => {
                if (!json.data) {
                    this.view.showPage( "error", { msg: "This app request failed to deliver proper data.", topmenu: this.apps} );
                } else {
                    let formdef = json.formdef.definition;
                    let datadef = json.datadef.definition;
//                    let formdef = JSON.parse( json.formdef.definition );
//                    let datadef = JSON.parse( json.datadef.definition );
                    this.model.setData( json.data, datadef );
                    this.model.setActions( formdef.actions );
                    this.view.showPage( "app", { form:formdef, datamodel: this.model, topmenu: this.apps});
                }
            }).catch( error => {
                console.log(error);
            });
    }
    
    getCallOptions() {
        let token = this.auth.getToken();
        return { 'Authorization': `Bearer ${token}`,  'Content-Type': 'application/json' };
    }
}