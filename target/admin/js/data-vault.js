export default class dataVault {
    constructor(datadef) {
        this.data = datadef;
        this.removeError = "";
        this.setid = 0;
    }

    getValue( path ) {
        this.foundvalue = "";
        this.found = false;
        var pathelements = path.split("/");
        this.getDeepValue( pathelements.reverse(), this.data.elements );
        return this.foundvalue;
    }

    setValue( path, value ) {
        var pathelements = path.split("/");
        this.data.elements = this.setDeepValue( pathelements.reverse(), this.data.elements, value );
    }

    addSetItem(path) {
        var pathelements = path.split("/");
        this.data.elements = this.addDeepSetItem( pathelements.reverse(), this.data.elements );
        return this.setid;
    }

    removeSetItem(path) {
        this.removeError = "";
        var pathelements = path.split("/");
        this.removeDeepSetItem( pathelements.reverse(), this.data.elements );
    }

    hasElement(path) {
        this.getValue( path );
        return this.found;
    }

    getSetItems( path ) {
        var result = this.getValue( path );
        if (this.found && result.length>0  && result[0].setid) {
            return result
        } else {
            return [];
        }
    }

    removeDeepSetItem( pathelements, data ) {
        var first = pathelements.pop();

        data.forEach(element => {        
            if (element.hasOwnProperty("name")) {
                if (element.name == first ) {
                    if (pathelements.length == 1 ) {
                        var newValue = [];
                        element.value.forEach( item => {
                            if (item.setid != pathelements[0]) {
                                newValue.push( item );
                            }
                        })
                        element.value = newValue;
                        return element;
                    } else {
                        element.value = this.removeDeepSetItem( pathelements, element );
                        return element;
                    }
                }
            } else if (element.hasOwnProperty("setid")) {
                if (element.rowid == first ) {
                    element.value = this.removeDeepSetItem( pathelements, element );
                    return element;
                }
            }            
        });
    }    

    addDeepSetItem( pathelements, data, value ) {
        var first = pathelements.pop();
        var result = [];

        data.forEach(element => {        
            if (element.hasOwnProperty("name")) {
                if (element.name == first ) {
                    if (pathelements.length == 0) {
                        if (element.type == "set" ) {
                            this.setid = this.findMax(element.value) + 1;
                            element.value.push( JSON.parse( JSON.stringify({ setid:  this.setid, value: element.elements }) ) );
                        } else {
                            this.setid = 0;
                        }
                    } else {
                        element.value = this.addDeepSetItem( pathelements, element.value, value );
                    }
                }
                result.push( element );                
            } else if (element.hasOwnProperty("setid")) {
                if (element.setid == first ) {
                    if (pathelements.length == 0) {
                        element.value = value;
                    } else {
                        element.value = this.addDeepSetItem( pathelements, element.value, value );
                    }
                }
                result.push( element );
            } else {
                result.push( element );
            }
        });
        return result;
    }

    findMax( elements ) {
        var max = 0;
        elements.forEach(element => {
            if (element.setid > max ) {
                max = element.setid;
            }
        });
        return max;
    }

    getDeepValue( pathelements, data ) {
        var first = pathelements.pop();
        data.some(element => {
            if (element.hasOwnProperty("name")) {
                if (element.name == first ) {
                    if (pathelements.length == 0) {
                        this.foundvalue = element.value;
                        this.found = true;
                        return true;
                    } else {
                        return this.getDeepValue( pathelements, element.value );
                    }
                }
            } else if (element.hasOwnProperty("setid")) {
                if (element.setid == first ) {
                    if (pathelements.length == 0) {
                        this.foundvalue = element.value;
                        this.found = true;
                        return true;
                    } else {
                        return this.getDeepValue( pathelements, element.value);
                    }
                }
            }            
        });
    }

    setDeepValue( pathelements, data, value ) {
        var first = pathelements.pop();
        var result = [];

        data.forEach(element => {        
            if (element.hasOwnProperty("name")) {
                if (element.name == first ) {
                    if (pathelements.length == 0) {
                        element.value = value;
                    } else {
                        element.value = this.setDeepValue( pathelements, element.value, value );
                    }
                }
                result.push( element );                
            } else if (element.hasOwnProperty("setid")) {
                if (element.setid == first ) {
                    if (pathelements.length == 0) {
                        element.value = value;
                    } else {
                        element.value = this.setDeepValue( pathelements, element.value, value );
                    }
                }
                result.push( element );
            } else {
                result.push( element );
            }
        });
        return result;
   }
}