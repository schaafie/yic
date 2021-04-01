export default class dataVault {
    constructor(data, datadef) {
        this.data = data;
        this.defintiion = datadef;
        this.actions = [];
    }

    setData(data) { 
        this.data = data; 
    }

    setData(dataDef) { 
        this.datadef = dataDef; 
    }

    register( element, path ) {
        
    }


}