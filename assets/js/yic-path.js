export const YicPath = {
    splitName(name) { 
        return name.split("/") 
    },
    addChild(parent, child) { 
        return (parent == "") ? child : `${parent}/${child}` 
    },
    makeSteps(name) { 
        return name.split("/") 
    },
    nextStep(iterator) { 
        return iterator.shift() 
    },
    hasSteps(iterator) { 
        return (iterator.length > 0) 
    },
    getDirectChildName(parent, child) {
        if (child.startsWith(parent)) {
            let rest = child.slice(parent.length);
            if (rest.startsWith("/")) rest = rest.substring(1);
            if (!(rest.includes("/") || rest=="")) return rest;
        }
        return false;
    }
}