import YicDataDef from "./yic-datadef";

export default class YicDatamodel {

    constructor( auth ) {
        this.auth = auth;
        this.registrations = [];
    }

    setData(data, datadef, action) {
        this.datadef = new YicDataDef(datadef);
        this.model = this.json2model("root",data);
        this.action = action;
    }

    save() {

        let actionparts = [];

        this.action.split('/').forEach( (actionpart) => {
            if (actionpart.startsWith(":")) {
                let name = actionpart.slice(1);
                let value =  this.getValue( name );
                if (value !== undefined) {
                    actionparts.push( value );
                } else {
                    actionparts.push( "undef" );
                }
            } else {
                actionparts.push(actionpart);
            }
        })
        let action = YicConf.baseUrl() + actionparts.join('/');
        console.log(action);
        fetch( action, {
            method: 'PATCH',
            body: JSON.stringify(this.model2json(this.model)),
            headers: { 
                'Authorization': `Bearer ${this.auth.getToken()}`, 
                'Content-Type': 'application/json' }
        })
        .then( this.handleErrors )
        .then( response => {
            return response.json();
        }).then( json => {
            if (json.errors) {
                for (let obj in json.errors) {
                    this.setErrors( obj, json.errors[obj]);
                }
            } 
            if (json.data) {
                console.log(json.data);
            }
        }).catch( error => {
            console.log(error);
        });
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

    getJson() { 
        return this.model2json(this.model); 
    }

    getValue( path = "" ) {
        let element = this.findElement( this.model, path.split('.'), false);
        if (element===undefined) {
            return element;
        } else {
            if (element.type == "object" || element.type == "array" ) {
                return element.items;
            } else {
                return element.value;
            }
        } 
    }

    registerListener( path, listener ) {
        let element = this.findElement( this.model, path.split('.'), false);
        if (element===undefined) {
            return false;
        } else {
            element.listeners.push( listener );
            return true;
        }
    }

    setValue( path, value, origin="" ) {
        let element = this.findElement( this.model, path.split('.'), true);

        // TODO: requires validations based on datamodel definition
        // TODO: requieres checks on object type => add element vs set value
        if ( element.value != value) {
            element.value = value;
            element.listeners.forEach( (listener) => { listener.onChange( path, value ); });
        }
    }

    getErrors( path ) {
        let element = this.findElement( this.model, path.split('.'), false);
        return element.errors;
    }

    setError( path, error ) {
        let element = this.findElement( this.model, path.split('.'), false);
        element.errors.push( error );
        element.listeners.forEach( (listener) => { listener.onError( path, value ); });
    }

    setErrors( path, errors ) {
        let element = this.findElement( this.model, path.split('.'), false);
        element.errors = errors;
        element.listeners.forEach( (listener) => { listener.onError( path, errors ); });
    }

    // -----------------------------------
    // Private methods.
    // -----------------------------------

    findElement( model, list, create=false, parent="" ) {
        // TODO: allow for more complex JSON-path queries.
        let result = false;
        let next = list.shift();
        if (next === undefined || next === "") result = model;

        if (model.type == 'object' || model.type=='array') {
            model.items.forEach( item => {
                if (item.name == next) {
                    result = this.findElement(item, list, create, next);
                }
            });
        }

        // When the item is not found
        //    And the search is at this level (deep item create is not allowed, this creates level with no value)
        //    And findElement states that if not found, create an new item (Create = true)
        // Then create a new item, add it to the model 
        //    And return the reference to the new item
        if (result===false && list.length==0 && create) {
            let result = undefined;
            let item = this.datadef.getNode(parent, next);
            if (item !== undefined) {
                if (model.type == 'object' || model.type=='array') {
                    let index = model.items.push(item) - 1;
                    result = model.items[index];
                }
            }
            return result;
        } else return (result === false)?undefined:result;  // if the item is not found or created, return undefined else return reference to item
    }
    
    findDef( name ) {
        let result = undefined;
        this.datadef.datatypes.forEach( datatype => {
            if (datatype.name == name) result = datatype;
        });
        return result;
    }

    json2model( name, data ) {
        switch(typeof data) {
            case 'object':
                if (Array.isArray(data)) {
                    var array = {name: name, type:"array", errors:[], listeners:[], items:[] };
                    data.forEach((item, index) => {
                        array.items.push( this.json2model( `row_${index}` , item ));
                    });
                    return array;
                } else if (data ===null) {
                    let node = this.datadef.findDef(name);
                    let type = node.basetype;
                    return {name: name, type: type, errors:[], listeners:[], items:[] };
                } else {
                    var object = {name: name, type:"object", errors:[], listeners:[], items:[] };
                    for (const [key, item] of Object.entries(data)) {
                        object.items.push( this.json2model( key, item ) );
                    }                    
                    return object;
                }
                break;
            case 'string':
                return { name: name, type: "string", value: data, errors:[], listeners:[] };
                break;
            case 'number':
                return { name: name, type: "number", value: data, errors:[], listeners:[] };
                break;
            case 'boolean':
                return { name: name, type: "boolean", value: data, errors:[], listeners:[] };
                break;
        }
    }

    model2json( model ) {
        switch(model.type) {
            case "object":
                var object = {};
                model.items.forEach((item, index)=>{
                    object[item.name]=this.model2json(item);
                });
                return object;    
                break;
            case "array":
                var array = [];
                model.items.forEach((item, index) => {
                    array.push(this.model2json(item));
                });
                return array;        
                break;
            case "string":
                return model.value;
                break;
            case "id":
            case "number":
                return parseInt(model.value);
                break;
            case "boolean":
                return Boolean(model.value);
                break;
        }
    }
}