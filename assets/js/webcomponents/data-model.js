export default class dataModel {

    constructor(data, datadef) {
        this.createDataModel(data,datadef);
        this.registrations = [];
    }

    getValue( path ) {
        let temp = this.model;
        pathElements = path.split('.');
        pathElements.forEach(element => {
            for (const [key, val] of Object.entries(temp)) {
                if (key=="name" && val==element) {

                }
            }
        });
    }

    getErrors( path ) {}
    setValue( path, value, origin="" ) {}
    setErrors( path, errors ) {}

    createDataModel(data, dataDef) { 
        this.model = this.json2model("root",data); 
    }

    getJson() { 
        return this.model2json(this.model); 
    }

    json2model( name, data ) {
        switch(typeof data) {
            case 'object':
                if (Array.isArray(data)) {
                    var array = {name: name, type:"array", items:[] };
                    data.forEach((item, index) => {
                        array.items.push( this.json2model( `row_${index}` , item ));
                    });
                    return array;
                } else {
                    var object = {name: name, type:"object", items:[] };
                    for (const [key, item] of Object.entries(data)) {
                        object.items.push( this.json2model( key, item ) );
                    }                    
                    return object;
                }
                break;
            case 'string':
                return { name: name, type: "string", value: data }
                break;
            case 'number':
                return { name: name, type: "number", value: data }
                break;
            case 'boolean':
                return { name: name, type: "boolean", value: data }
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