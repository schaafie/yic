export default class dataVault {
    constructor(data, datadef) {
        this.data = this.setData(data);
        this.setDataDefinition(datadef);
        this.registrations = [];
    }

    setData(data) {
        var dataset = [];
        this.type = (Array.isArray(data)?"list":"item");
        if (this.type == "list") {
            data.forEach( (row, rowindex) => {
                dataset[rowindex] = [];
                var rowEntries = Object.entries(row);
                rowEntries.forEach( element => {
                    dataset[rowindex].push ( { name: element[0], value:element[1] } );
                });
            });
        } else {
            var dataEntries = Object.entries(data);
            dataEntries.forEach( element => {
                dataset.push({
                    name: element[0],
                    value: element[1],
                    validations: [],
                    type: "",
                    required: false,
                    errors: [],
                    registered: []
                });
            });    
        }
        return dataset;
    }

    setDataDefinition(dd) { 
        this.datadef = dd.definition;
        this.actions = dd.actions;

        if (this.type == "list") {
            this.data.forEach( (row, rowindex) => {
                row.forEach( ( item, itemindex ) => {
                    this.datadef.elements.forEach( element => {
                        if (item.name == element.name ) {
                            this.data[rowindex][itemindex].type = element.type;
                        }
                    });
                });
            });  
        } else {
            this.datadef.elements.forEach( element => {
                var found = false;
                this.data.forEach( (item, index) => {
                    if (item.name == element.name) {
                        found = true;
                        this.data[index].type = element.type;
                        this.data[index].validations = element.validations;
                        this.data[index].required = element.required;
                    }
                });
                if (!found) this.data.push({
                    name: element.name, 
                    type: element.type, 
                    validations: element.validations, 
                    required: element.required
                });
            });
        }
    }

    register( element, path ) {
        if ( path.indexOf("/") == -1 ) {
            this.data.forEach( (item, index)=>{
                if (item.name == path) {
                    this.data[index].registered.push( element );
                }
            });
        } else {
            // TODO: deep value changes
        }
    }

    getValue( path ) {
        var foundValue;
        if ( path.indexOf("/") == -1 ) {
            this.data.forEach( (element, index) => {
                if (element.name == path) {
                    foundValue = element.value;
                }
            });
        } else {
            // TODO: find deep value
        }
        return foundValue;
    }    

    setValue( path, value ) {
        if ( path.indexOf("/") == -1 ) {
            this.data.forEach( (item, index) => {
                if (item.name == path) {
                    this.data[index].errors = [];
                    item.validations.forEach( validation => {
                        var error = this.isInvalid( value, validation );
                        if (error) this.data[index].errors.push(error);
                    });
                }
                if (this.data[index].errors.length > 0) {
                    this.data[index].value = value;
                    this.registrations.forEach( element => {
                        var event = new CustomEvent('dataChange', { value: value, name: path });
                        element.dispatchEvent( event );
                    });
                }
            });
        } else {
            // TODO: deep value changes
        }
    }

    hasElement(path) {
        var hasElement = false;
        if ( path.indexOf("/") == -1 ) {
            this.data.forEach( element => {
                if (element.name == path) {
                    hasElement = true;
                }
            });
        } else {
            // TODO: deep element check
        }

        return hasElement;
    }

    rowCount() {
        return this.data.length;
    }

    getSetElement( row, path ) {
        var element = {};
        this.data[row].forEach(item =>{
            if (item.name == path) {
                element = item;
            }
        });
        return element;
    }

    getElementDefinition(path) {
        var foundElement = false;
        if ( path.indexOf("/") == -1 ) {
            this.datadef.definition.elements.forEach(element => {
                if (element.name == path) {
                    foundElement = element;
                }
            });
        } else {
            // TODO: find deep element
        }

        if (foundElement!==false) {
            return foundElement;
        } else {
            return { name: path, required: false, validations: [], type: "all" };
        }  
    }



    get() {

    }

    save( onErrorCallback, onSuccesCallback ) {
        var createAcion = {};
        var updateAction = {};
        this.actions.forEach( action => {
            if (action.id == "CREATE") createAcion = action;
            else if (action.id == "UPDATE") updateAction = action;
        });
        
        var updateURL = updateAction.action.url;
        var missingData = false;
        updateAction.parms.forEach( parm => {
            if (parm.hasOwnProperty('data_item')) {
                var value = this.getValue( parm.data_item );
                if ( value !== undefined ) {
                    updateURL = updateURL.replace( parm.url_item, value );
                } else {
                    missingData = true;
                }
            }
        });

        var xhr = new XMLHttpRequest();
        if (!missingData) {
            xhr.open(updateURL.method, updateURL, true);
        } else {
            xhr.open(createAcion.method, createAction.url, true);
        }
        
        xhr.onreadystatechange = function () {
            if(xhr.readyState === XMLHttpRequest.DONE) {
                var status = xhr.status;
                if (status === 0 || (status >= 200 && status < 400)) {
                    onSuccesCallback( xhr.responseText );
                } else {
                    onErrorCallback( xhr.responseText );
                }
            }
        };
        
        var formData = new FormData();
        this.data.forEach( item => {
            formData.append( item.name, item.value );
        });

        xhr.send(formData);
    }

    delete() {
        this.actions.forEach( action => {
            if (action.id == "DELETE") {

            }
        });
    }


}