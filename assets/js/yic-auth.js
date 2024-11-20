export default class YicAuth {
    
    constructor() {
        this.jwt = "";
        this.uname = "";
        this.listeners = [];
    }

    isLoggedIn() { return this.jwt!=="";}

    getLoggedInUser() { return this.uname; }

    getToken() { return this.jwt; }

    register( object ) {
        this.listeners.push(object);
    }

    doLogout() { 
        this.jwt = ""; 
        this.uname = "";
        this.listeners.forEach(element => {
            element.authChanged();    
        });
    }

    doLogin( uname, upassword ) {
        let xhr = new XMLHttpRequest();
        let data = { login: uname, password: upassword }
        this.uname = uname;

        xhr.open('POST', YicConf.baseUrl()+'sign_in', true);
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
        // console.log( "Error: " + txt );
        this.uname = "";
        let errObject = JSON.parse( txt );
        this.listeners.forEach(element => {
            element.authFailed( errObject );    
        });
        
    }

    handleSucces( txt ) {
        // console.log( "Succes: " + txt );
        let jsonObject = JSON.parse(txt);
        this.jwt = jsonObject.data.token;
        this.listeners.forEach(element => {
            element.authChanged();    
        });
    }
}