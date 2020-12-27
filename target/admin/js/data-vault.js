export default class dataVault {
    constructor(datadef) {
        this.data = datadef;
        this.removeError = "";
        this.setid = 0;
    }

    getValue( path ) {
        var pathelements = path.split("/");
        return this.getDeepValue( pathelements.reverse(), this.data.elements );
    }

    setValue( path, value ) {
        var pathelements = this.path.split("/");
        return this.setDeepValue( pathelements.reverse(), this.data.elements, value );
    }

    addSetItem(path) {
        var pathelements = this.path.split("/");
        this.addDeepSetItem( pathelements.reverse(), this.data.elements );
    }

    removeSetItem(path) {
        this.removeError = "";
        var pathelements = this.path.split("/");
        this.removeDeepSetItem( pathelements.reverse(), this.data.elements );
    }

    removeDeepValue( pathelements, data ) {
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
                        element.value = this.removeDeepValue( pathelements, element );
                        return element;
                    }
                }
            } else if (element.hasOwnProperty("setid")) {
                if (element.rowid == first ) {
                    element.value = this.removeDeepValue( pathelements, element );
                    return element;
                }
            }            
        });
    }    

    addDeepSetItem(pathelements) {
        var first = pathelements.pop();

        data.forEach(element => {        
            if (element.hasOwnProperty("name")) {
                if (element.name == first ) {
                    if (pathelements == []) {
                        if (element.type == "set" ) {
                            this.setid = this.findmax(element.value, 0) + 1;
                            element.value.push( { 
                                setid:  this.setid,
                                value: JSON.parse( element.elements.stringefy() )
                            });
                            return element;
                        } else {
                            this.setid = 0;
                            return element;
                        }
                    } else {
                        element.value = this.addDeepSetItem( pathelements );
                        return element;
                    }
                }
            } else if (element.hasOwnProperty("setid")) {
                if (element.rowid == first ) {
                    if (pathelements == []) {
                        this.setid = 0;
                        return element;
                    } else {
                        element.value = this.addDeepSetItem( pathelements );
                        return element;
                    }
                }
            }            
        });        
    }

    findMax( elements ) {
        var max = 0;
        elements.array.forEach(element => {
            if (element.setid > max ) {
                max = element.setid;
            }
        });
        return max;
    }

    getDeepValue( pathelements, data ) {
        var first = pathelements.pop();
        var value = '';
        data.some(element => {
            if (element.hasOwnProperty("name")) {
                if (element.name == first ) {
                    if (pathelements.length == 0) {
                        value = element.value;
                        return true;
                    } else {
                        return this.getDeepValue( pathelements, element.value );
                    }
                }
            } else if (element.hasOwnProperty("setid")) {
                if (element.setid == first ) {
                    if (pathelements.length == 0) {
                        value = element.value;
                        return true;
                    } else {
                        return this.getDeepValue( pathelements, element.value);
                    }
                }
            }            
        });
        return value;
    }

    setDeepValue( pathelements, data, value ) {
        var first = pathelements.pop();

        data.forEach(element => {        
            if (element.hasOwnProperty("name")) {
                if (element.name == first ) {
                    if (pathelements == []) {
                        element.value = value;
                        return element;
                    } else {
                        element.value = this.setValue( pathelements, element, value );
                        return element;
                    }
                }
            } else if (element.hasOwnProperty("setid")) {
                if (element.rowid == first ) {
                    if (pathelements == []) {
                        return element.value;
                    } else {
                        return this.setValue( pathelements, element, value );
                    }
                }
            }            
        });
    }
}