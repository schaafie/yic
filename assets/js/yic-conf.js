(function (window, document) {
    "use strict";

    var options = {
        baseUrl: `http://localhost:4000/api/`
    }

    window.YicConf = {
        baseUrl: function() { return options.baseUrl } 
    }

    if (typeof module === "object" && typeof module.exports === "object") {
        module.exports = YicConf;
    } else if (typeof define === "function" && define.amd) {
        define(function () {
            return YicConf;
        });
    } else {
        this.YicConf = YicConf;
    }
}.call(this, window, document));
