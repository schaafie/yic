export default class YicDataDef {

    constructor(datadef) {
        this.datadef = datadef; 
    }

    findDef( name ) {
        let result = undefined;
        proploop: for (const [key, value] of Object.entries(this.datadef.properties)) {
            if (key == name) {
                result = value;
                break proploop;
            }
        }
        return result;
    }

    getNode(parentname, nodename) {
        let result = undefined;
//        let parent_def = (parentname=="")?this.findDef(this.datadef.root):this.findDef(parentname);
        let parent_def = (parentname=="")?this.datadef:this.findDef(parentname);
        let element_def = this.findDef(nodename);
        if (parent_def!==undefined && element_def!==undefined) {
            if (parent_def.basetype == "map") {
                parent_def.fields.forEach( (p_field) => {
                    if (p_field.field == nodename) {
                        let element = {};
                        element.name = nodename;
                        element.listeners = [];
                        element.errors = [];
                        switch(element_def.basetype) {
                            case "array":
                                element.type="array";
                                element.items = [];
                                break;
                            case "map":
                                element.type="map";
                                element.items = [];
                                break;
                            case "id":
                                element.type="number";
                                break;
                            case "string":
                            case "number":
                            case "boolean":
                                element.type = element_def.basetype;
                                break;
                        }
                        if (element_def.default) element.value = element_def.default;

                        result = element;
                    }
                });
            }
        }
        return result;
    }
    
}