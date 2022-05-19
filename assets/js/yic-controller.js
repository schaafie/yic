import YicDatamodel from "./yic-datamodel";

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
        
    loadApps() {
        this.apps = [];
        let thisapp = this;
        this.path = "/json/apps.json";
        fetch( this.path, this.getCallOptions() ).then( response => {
            return response.json();
        }).then( data => {
            data.apps.forEach( (app) => {
                app.callback = function() { thisapp.doCommand(app.json); };
                this.apps.push(app);
            });
            this.apps.push( { title: this.auth.getLoggedInUser(), type: 'dropdown', align: "right", items: [{title: "logout", type: "link", callback: () => { this.auth.doLogout(); }}] } );
            this.view.showPage("index", {topmenu: this.apps});
        });
    }

    doAuth( user, password ) {
        this.auth.doLogin( user, password) ;
    }

    doCommand( jsonCmd ) { 
        fetch( `http://localhost:4000/api/${jsonCmd}`, this.getCallOptions() )
            .then( this.handleErrors )
            .then( response => {
                return response.json();
            }).then( json => {
                if (!json.data) {
                    this.view.showPage( "error", { msg: "This app request failed to deliver proper data.", topmenu: this.apps} );
                } else {
                    this.model = new YicDatamodel(json.data.data,json.datadef);
                    let formdef = json.formdef.data;
                    this.view.showPage( "app", { form:formdef, datamodel: this.model, topmenu: this.apps});
                }
            }).catch( error => {
                console.log(error);
            });
    }
    
    handleErrors(response) {
        if (!response.ok) {
            console.log(response);
            throw Error(response.statusText);
        }
        return response;
    }

    getCallOptions() {
        let token = this.auth.getToken();
        return { 
            headers: { 
                'Authorization': `Bearer ${token}`, 
                'Content-Type': 'application/json' }
        }
    }
}