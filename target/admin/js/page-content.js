export default class pageContent {
    constructor() {
        this.menuDef = {
            topMenu: [
                { url: "", title: "Content" },
                { url: "", title: "Flows" },
                { url: "", title: "Forms" }
            ],
            contextMenu: []
        }

        this.formDef = {
            elements: [
                {
                    name: "firstname",
                    label: "Your first name",
                    type: "text",
                    validations: [], 
                    required: "true",
                    value: "Pieter"
                },
                {
                    name: "lastname",
                    label: "Your last name",
                    type: "text",
                    validations: [],
                    required: "true",
                    value: "Schaafsma"
                },
                {
                    name: "email",
                    label: "Your email address",
                    type: "email",
                    validations: [],
                    required: "true",
                    value: "pieter@jort.net"
                },
                {
                    name: "birthdate",
                    label: "Your birthdate",
                    type: "date",
                    validations: [],
                    required: "false",
                    min: "1900-01-01",
                    max: "today",
                    value: "11-10-1969"
                },
                {
                    title: "Friends",
                    type: "rows",
                    rowdef: { type: "row", elements: [
                        { name: "firstname", label: "First name", type: "text", validations: [],  required: "true" },
                        { name: "lastname", label: "Last name", type: "text", validations: [], required: "true" } 
                    ]},
                    elements: [
                        {
                            type: "row",
                            rowid: 1,
                            elements: [
                                {
                                    name: "firstname",
                                    label: "Your first name",
                                    type: "text",
                                    validations: [], 
                                    required: "true",
                                    value: "Karen"
                                },
                                {
                                    name: "lastname",
                                    label: "Your last name",
                                    type: "text",
                                    validations: [],
                                    required: "true",
                                    value: "Leijnse"
                                }
                            ]
                        },
                        {
                            type: "row",
                            rowid: 2,
                            elements: [
                                {
                                    name: "firstname",
                                    label: "Your first name",
                                    type: "text",
                                    validations: [], 
                                    required: "true",
                                    value: "Jort"
                                },
                                {
                                    name: "lastname",
                                    label: "Your last name",
                                    type: "text",
                                    validations: [],
                                    required: "true",
                                    value: "Schaafsma"
                                }
                            ]
                        }
                    ]
                }

            ],
            layout:[],
            globalValidations: [],
            title: "Basic Form"
        }
    }

    setMenu() {
        document.querySelector("yic-top-menu").setMenu( this.menuDef.topMenu );
        if (this.menuDef.contextMenu.length == 0) {
            document.querySelector("#content").classList.remove("extended");
            document.querySelector("#content").classList.add("collapsed");
        } else {
            document.querySelector("yic-side-menu").setMenu( this.menuDef.contextMenu );
            document.querySelector("#content").classList.remove("collapsed");
            document.querySelector("#content").classList.add("extended");
        }
    }


    setContent() {
        document.querySelector("yic-form").setDefinition( this.formDef );
    }

} 