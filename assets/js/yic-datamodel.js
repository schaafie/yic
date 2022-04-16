export default class YicDatamodel {

    constructor(data, datadef) {
        this.model = this.json2model("root",data); 
        this.registrations = [];
    }

    getJson() { 
        return this.model2json(this.model); 
    }

    getValue( path ) {
        let element = this.findElement( this.model, path.split('.'));

        if (element.type == "object" || element.type == "array" ) {
            return element.items;
        } else {
            return element.value;
        }
    }

    registerListener( path, listener ) {
        let element = this.findElement( this.model, path.split('.'));
        element.listeners.push( listener );

    }

    setValue( path, value, origin="" ) {
        let element = this.findElement( this.model, path.split('.'));

        // TODO: requires validations based on datamodel definition
        // TODO: trigger registered processes
        // TODO: requieres checks on object type => add element vs set value
        element.value = value;
    }

    getErrors( path ) {
        let element = this.findElement( this.model, path.split('.'));
        return element.errors;
    }

    setError( path, error ) {
        let element = this.findElement( this.model, path.split('.'));
        element.errors.push( error );
    }

    setErrors( path, errors ) {
        let element = this.findElement( this.model, path.split('.'));
        element.errors = errors;
    }

    // -----------------------------------
    // Private methods.
    // -----------------------------------

    findElement( model, list ) {
        // TODO: allow for more complex JSON-path queries.
        let result = false;
        let next = list.shift();
        if (next === undefined) result = model;

        if (model.type == 'object' || model.type=='array') {
            model.items.forEach( item => {
                if (item.name == next) {
                    result = this.findElement(item, list);
                }
            });
        }

        if (result === false) throw "Path error";
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
            case "number":
            case "boolean":
                return model.value;
                break;
        }
    }
}