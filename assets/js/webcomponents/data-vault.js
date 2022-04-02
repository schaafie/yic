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

    getErrors( path ) {
        var foundValue;
        if ( path.indexOf("/") == -1 ) {
            this.data.forEach( (element, index) => {
                if (element.name == path) {
                    foundValue = element.errors;
                }
            });
        } else {
            // TODO: find deep value
        }
        return foundValue;
    }    

    setValue( path, value, origin="" ) {
        if ( path.indexOf("/") == -1 ) {
            this.data.forEach( (item, index) => {
                if (item.name == path) {
                    if ( this.data[index].value !== value )
                    {                   
                        this.data[index].value = value;
                        this.data[index].registered.forEach( element => {
                            var event = new CustomEvent('dataChanged', {detail: { value: value, name: path }} );
                            element.dispatchEvent( event );
                        });
                        var errors = [];
                        item.validations.forEach( validation => {
                            var error = this.isInvalid( value, validation );
                            if (error) errors.push(error);
                        });
                        this.setErrors( path, errors );
                    }                   
                }
            });
        } else {
            // TODO: deep value changes
        }
    }

    setErrors( path, errors ) {
        if ( path.indexOf("/") == -1 ) {
            this.data.forEach( (item, index) => {
                if (item.name == path) {
                    if (this.data[index].errors !== errors) {
                        this.data[index].errors = errors;
                        this.data[index].registered.forEach( element => {
                            var event = new CustomEvent('errorsRaised', {detail:{ errors: errors, name: path }});
                            element.dispatchEvent( event );
                        });
                    }
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
        
        // Check the updata URL for elements that define the primary key as part of URL
        var updateURL = updateAction.action.url;
        var missingData = false;
        updateAction.action.parms.forEach( parm => {
            if (parm.hasOwnProperty('data_item')) {
                var value = this.getValue( parm.data_item );
                if ( value !== undefined ) {
                    updateURL = updateURL.replace( parm.url_item, value );
                } else {
                    missingData = true;
                }
            }
        });

        // Build XML HTTP Request.
        // Distinguish between CREATE and UPDATE method
        var xhr = new XMLHttpRequest();
        if (!missingData) {
            xhr.open(updateAction.action.method, updateURL, true);
        } else {
            xhr.open(createAcion.action.method, createAction.action.url, true);
        }
        // MUST HAVE! JSON content-type
        xhr.setRequestHeader('Content-Type', 'application/json');
        
        // Define followup actions. 
        // Use callback funtions as defined as function arguments
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
        
        // Build the payload. 
        // Format is defined in the datadefinition
        // If no format is defined, assume basic json format
        var data = {};
        switch(this.datadef.dataformat.type) {
            case "phoenix":
                var formData = {};
                this.data.forEach( item => {
                    formData[item.name] = item.value;
                });
                data[this.datadef.dataformat.base] = formData;
                break;
            default:
                this.data.forEach( item => {
                    data[item.name] = item.value;
                });
        }
        xhr.send(JSON.stringify( data ));
    }

    delete() {
        this.actions.forEach( action => {
            if (action.id == "DELETE") {

            }
        });
    }


}