import { YicPath as Path } from "./yic-path.js";
import YicDataDef from "./yic-datadef.js";

export default class YicDatamodel {

    constructor( auth ) {
        this.auth = auth;
        this.items = [];
        this.registrations = [];
    }

    setData(data, datadef) {
        this.items = [];
        this.registrations = [];
        this.datadef = new YicDataDef(datadef);
        this.setValue("", data);
    }

    setActions( actions ) {
        actions.forEach( action => {
            if (action.list) this.getaction = action.list.url;
            if (action.edit) this.editaction = action.edit.url;
            if (action.save) this.saveaction = action.save.url;
            if (action.create) this.createaction = action.create.url;
            if (action.delete) this.deleteaction = action.delete.url;
        });
    }

    /* ------------------
    Actions 
    ------------------ */

    delete(pk){
        let deleteaction = `${this.deleteaction}/${pk}`;
        fetch( YicConf.baseUrl() + deleteaction, { 
                method: "DELETE", 
                headers: { 
                    'Authorization': `Bearer ${this.auth.getToken()}`, 
                    'Content-Type': 'application/json' 
        }})
        .then( this.handleErrors )
        .then( response => {
            return response.ok;
        }).catch( error => {
            console.log(error);
            return false;
        });
    }

    save() {
        let saveaction = this.buildaction(this.saveaction);
        let payload = this.getValue("");
        // if buildkeys are set then save else create
        if (this.buildkeys) {
            fetch( YicConf.baseUrl() + saveaction, {
                method: 'PATCH',
                body: JSON.stringify(payload),
                headers: { 
                    'Authorization': `Bearer ${this.auth.getToken()}`, 
                    'Content-Type': 'application/json' }
            })
            .then( this.handleErrors )
            .then( response => { return response.json(); })
            .then( json => {
                if (json.errors) {
                    for (let obj in json.errors) {
                        this.setErrors( obj, json.errors[obj]);
                    }
                } 
                if (json.data) {
                    console.log(json.data);
                }
            }).catch( error => { console.log(error); });    
        } else {
            fetch( YicConf.baseUrl() + this.createaction, {
                method: 'POST',
                body: JSON.stringify(payload),
                headers: { 
                    'Authorization': `Bearer ${this.auth.getToken()}`, 
                    'Content-Type': 'application/json' }
            })
            .then( this.handleErrors )
            .then( response => { return response.json(); })
            .then( json => {
                if (json.errors) {
                    for (let obj in json.errors) {
                        this.setErrors( obj, json.errors[obj]);
                    }
                } 
                if (json.data) {
                    console.log(json.data);
                }
            }).catch( error => { console.log(error); });    
        }        
    }

    buildaction(action, path = "") {
        let actionparts = [];
        this.buildkeys = false;
        action.split('/').forEach( (actionpart) => {
            if (actionpart.startsWith(":")) {
                let value="";
                if (path === "") {
                    let name  = actionpart.slice(1);
                    value = this.getValue( name );    
                } else {
                    value = this.getValue( path );
                }
                if (value !== undefined) {
                    actionparts.push( value );
                    this.buildkeys = true;
                } else {
                    actionparts.push( "undef" );
                }
            } else {
                actionparts.push(actionpart);
            }
        });
        return actionparts.join('/');
    }

    handleErrors(response) {
        let err = false;
        if (!response.ok) {
            switch (response.status) {
                case 422:
                    let err = true;
                    break;
                default:
                    throw Error(response.statusText);
            }
        }
        return response;
    }

    /* -----------------------
    Internal code
    ----------------------- */
    getValue(pathName = "") {
        let item = this.getItem(pathName);
        if (item==undefined) return item;
        switch (item.type) {
            case "object":
                let object = item.value;
                this.items.forEach(subitem => {
                    let childName = Path.getDirectChildName(pathName, subitem.path);
                    if (childName) object[childName] = this.getValue(subitem.path);
                });
                return object;
                break;
            case "array":
                let array = item.value;
                this.items.forEach(subitem => {
                    let childName = Path.getDirectChildName(pathName, subitem.path);
                    if (childName) array[childName] = this.getValue(subitem.path);
                });
                return array;
                break;
            case "string":
            case "boolean":
            case "integer":
                return item.value;
                break;
        }
    }

    getItem(pathName) {
        let index = this.items.findIndex(item => item.path == pathName);
        if (index == -1) return undefined;
        return this.items[index];
    }

    setValue(pathName, value) {
        try { 
            let dditem  = this.datadef.getItem( pathName );
            let item    = this.getItem(pathName);
            if (item == undefined) {
                this.buildPath(pathName);
                this.setValue(pathName, value);
            } else {
                switch (typeof (value)) {
                    case "object":
                        if (Array.isArray(value)) {
                            // Object is an Array
                            item.value = [];
                            value.forEach( ( arrayItem, index ) => {
                                let newName = Path.addChild( pathName, index.toString() );
                                try { 
                                    if (this.datadef.getItem(newName) != undefined ) {
                                        this.setValue( newName, arrayItem );
                                    } else {
                                        item.value.push( arrayItem );
                                    }
                                } catch( error ) {
                                    item.value.push( arrayItem );
                                }                            
                            });
                        } else if (value === null) {
                            // Object is of null type

                        } else {
                            // Object is an Object
                            let objType = this.datadef.getObjectType( dditem );
                            if (objType > 0) {
                                item.value = {};
                                for (const [key, objectItem] of Object.entries(value)) {
                                    let newName = Path.addChild(pathName, key);
                                    this.setValue( newName, objectItem );
                                }
                            } else if (objType==0) {
                                item.value = value;
                            } else throw new Error(`Object is invalid`);  
                        }
                    break;
                    case "number":
                        switch (item.type) {
                            case "integer":
                                item.value = Math.trunc(value);
                                break;
                            case "number":
                                item.value = value;
                                break;
                            default:
                                throw new Error(`Set Value error. Value ${value} at path ${pathName} is not of type ${item.type}.`);
                                break;
                        }
                        break;
                    case "string":
                        switch( item.type ) {
                            case "object":
                                let jsonObj = JSON.parse( value );
                                let strObjType = this.datadef.getObjectType( dditem );
                                if (strObjType == 0) {
                                    item.value = jsonObj;
                                } else if (strObjType>0) {
                                    item.value = {};
                                    for (const [key, jsonItem] of Object.entries(jsonObj)) {
                                        let newName = Path.addChild(pathName, key);
                                        this.setValue(newName, jsonItem);
                                    }    
                                } else throw new Error(`Object is invalid`);
                                break;
                            case "string":
                                item.value = value;
                                break;
                            default:
                                throw new Error(`Set Value error. Value ${value} at path ${pathName} is not of type ${item.type}.`);
                                break;
                        }
                        break;
                    case "boolean":
                        if (item.type != "boolean") throw new Error(`Set Value error. Value ${value} at path ${pathName} is not of type ${item.type}.`);
                        item.value = value;
                        break;
                }
                item.listeners.forEach( (listener) => { 
                    listener.onChange( pathName, item.value ); }
                );
                this.validateItem(item.path, item.value);    
            }
        } catch(error) {
            console.log(`ERROR. Message: ${error.message}`);
            return;
        }
    }

    buildPath(pathName) {
        let nextName = "";
        let iterator = Path.makeSteps(pathName);
        while (Path.hasSteps(iterator)) {
            nextName = Path.addChild(nextName, Path.nextStep(iterator));
            let index = this.items.findIndex(item => item.path == nextName);
            if (index == -1) this.createItem(nextName);
        }
    }

    createItem(pathName) {
        let definition = this.datadef.getItem(pathName);
        let type = (definition!=undefined)?definition.type:definition;
        let newItem = { path: pathName, type: type, errors: [], listeners: [] };
        this.items.push(newItem);
    }

    fullValidation() {
        this.items.forEach(item => {
            this.validateItem(item.path, item.value, this.items);
        });
    }

    validateItem(pathName, value) {
        this.setErrors(pathName, this.datadef.validate(pathName, value, this.items));
    }

    getErrors(pathName) {
        let item = this.getItem(pathName);
        if (item == undefined) return [];
        return item.errors;
    }

    setErrors( pathName, errors ) {
        let item = this.getItem(pathName);
        if (item==undefined) return false;
        item.errors = errors;
        item.listeners.forEach( (listener) => { listener.onError( pathName, errors ); });
        return true;
    }

    registerListener( pathName, listener ) {
        let item = this.getItem(pathName);
        if (item==undefined) return false;
        item.listeners.push( listener );
        return true;
    }
}