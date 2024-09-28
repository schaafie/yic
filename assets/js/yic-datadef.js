import { YicPath as Path } from "./yic-path.js";

export default class YicDatadef {

    constructor(dd) {
        this.def = dd;
    }

    getItem(pathName) {
        let iterator = Path.makeSteps(pathName);
        let currentElement = this.def;
        while (Path.hasSteps(iterator)) {
            let nextStep = Path.nextStep(iterator);
            currentElement = this.getElement(currentElement, nextStep);
        }
        return currentElement;
    }

    getElement(datadefBranch, element) {
        // console.log(datadefBranch);
        // console.log(element);
        if (element == "") return datadefBranch;
        switch (datadefBranch.type) {
            case "object":
                for (const [key, value] of Object.entries(datadefBranch.properties)) {
                    if (key == element) return value;
                }
                throw new Error("Object property not defined!");
                break;
            case "array":
                return datadefBranch.items;
                break;
            default:
                throw new Error(`Element of type ${datadefBranch.type} not found!`);
                break;
        }
    }

    validate(pathName, value, items) {
        let item = this.getItem(pathName);
        let errors = [];
        switch (item.type) {
            case "integer":
                // Check for minimum Value
                if (Object.hasOwn(item, 'minimum')) {
                    if (Object.hasOwn(item, 'exclusiveMaximum') && item.exclusiveMaximum) {
                        if (value <= item.minimum) {
                            errors.push(`Value must be larger than or equeal to ${item.minimum}. Value was ${value}`);
                        }
                    } else {
                        if (value < item.minimum) {
                            errors.push(`Value must be larger than ${item.minimum}. Value was ${value}`);
                        }
                    }
                } 
                // Check for maximum Value
                if (Object.hasOwn(item, 'maximum')) {
                  if (Object.hasOwn(item, 'exclusiveMinimum') && item.exclusiveMinimum) {
                    if (value >= item.maximum) {
                        errors.push(`Value must be smaller than or equal to ${item.maximum}. Value was ${value}`);
                    }
                  } else {
                    if (value > item.maximum) {
                        errors.push(`Value must be smaller than ${item.maximum}. Value was ${value}`);
                    }
                  }
                } 
                // Check for multiples of Value
                if (Object.hasOwn(item, 'multipleOf') && (value % item.multipleOf == 0)) {
                    errors.push(`Value is not a multiple of ${item.multipleOf}`);
                }
                break;

            case "string":
                if (Object.hasOwn(item, 'minLength') && (value.length < item.minLength)) {
                    errors.push(`Value has not at least ${item.minLength} characters`);
                }
                if (Object.hasOwn(item, 'maxLength') && (value.length > item.maxLength)) {
                    errors.push(`Value has more then ${item.maxLength} characters`);
                }
                if (Object.hasOwn(item, 'pattern')) {
                    const regex = new RegExp(item.pattern);
                    if (!regex.test(value)) {
                        errors.push(`Value does not conform to the required string pattern (${item.pattern})`);
                    }
                }
                if (Object.hasOwn(item, 'format')) {
                    switch(item.format) {
                        case "email":
                            const mailpattern = "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
                            const regex = new RegExp(mailpattern);
                            if (!regex.test(value)) {
                                errors.push(`Value does contain a valid email address`);
                            }
                            break;
                        default:    
                            console.log(`Unknown format in in string validation rules (${item.format})`);
                            errors.push(`Value must match unknown fomat (${item.format})`);
                            break;
                    }
                }

                break;
            case "boolean":
                // No known validation rules (yet)
                break;
            case "object":
                if (Object.hasOwn(item, "required")) {
                    item.required.forEach(element => {
                        let child = Path.addChild(pathName, element);
                        let index = items.findIndex( listitem => listitem.path == child);
                        if (index == -1) {
                            errors.push(`Object is missing a required property (${element})`);
                        }
                        
                    });
                }
                // Check for additional properties (when not allowed)
                if (Object.hasOwn(item, "additionalProperties") && !item.additionalProperties) {
                    items.forEach( element => {
                        let child = Path.getDirectChildName(pathName, element.path);
                        if (child && !keys.includes( Object.keys(item.properties) ) ) {
                            errors.push(`Object property (${child}) is not allowed`); 
                        }
                    });
                }
                break;
            case "array":
                // TODO
                break;    
            default:
                console.log(`Unknown type in validation rules (${item.type})`);
                break;
        }
        return errors;
    }
}