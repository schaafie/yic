# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FormManager.Repo.insert!(%FormManager.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias FormManager.Repo
alias FormManager.Forms.Form
alias FormManager.Forms.Datasource

Repo.insert! %Datasource{
    id: 1,
    name: "Forms",
    version: "1.0",
    comment: "",
    definition: %{
        elements: [
          %{ name: "id", type: "integer", validations: [], required: "true" },
          %{ name: "name", type: "text", validations: [], required: "true" },
          %{ name: "version", type: "text", validations: [], required: "true" },
          %{ name: "author", type: "text", validations: [], required: "true" },
          %{ name: "definition", type: "formdefinition", validations: [], required: "true" } ],
        globalValidations: [],
        restapi: "" },
    actions: [  %{ id: "GETALL", name: "Get all forms", action: %{ method: "GET", url: "http://localhost:8080/api/form/forms", parms: []  } },
                %{ id: "GET", name: "Get a form by id", action: %{ method: "GET", url: "http://localhost:8080/api/form/forms/@id", parms: [%{url_item: "@id", data_item: "id"}] } },
                %{ id: "DELETE", name: "Delete a form", action: %{ method: "DELETE", url: "http://localhost:8080/api/form/forms/@id", parms: [%{url_item: "@id", data_item: "id"}] } },
                %{ id: "CREATE", name: "Create a form", action: %{ method: "POST", url: "http://localhost:8080/api/form/forms", parms: []  } },
                %{ id: "UPDATE", name: "Update a form", action: %{ method: "POST", url: "http://localhost:8080/api/form/forms/@id", parms: [%{url_item: "@id", data_item: "id"}] } } ]   
}

Repo.insert! %Datasource{
    id: 2,
    name: "Data sources",
    version: "1.0",
    comment: "",
    definition: %{ 
        elements: [
            %{ name: "id", type: "integer", validations: [], required: "true" },            
            %{ name: "name", type: "text", validations: [], required: "true" },            
            %{ name: "version", type: "text", validations: [], required: "true" },            
            %{ name: "definition", type: "json", validations: [], required: "true" },            
            %{ name: "actions", type: "array", validations: [], required: "true" } ],
        globalValidations: [],
        restapi: "" },
    actions: [  %{ id: "GETALL", name: "Get all forms", action: %{ method: "GET", url: "http://localhost:8080/api/form/datasources", parms: [] } },
                %{ id: "GET", name: "Get a form by id", action: %{ method: "GET", url: "http://localhost:8080/api/form/datasources/@id", parms: [ %{url_item: "@id", data_item: "id"}] } },
                %{ id: "DELETE", name: "Delete a form", action: %{ method: "DELETE", url: "http://localhost:8080/api/form/datasources/@id", parms: [ %{url_item: "@id", data_item: "id"}] } },
                %{ id: "CREATE", name: "Create a form", action: %{ method: "POST", url: "http://localhost:8080/api/form/datasources", parms: [] } },
                %{ id: "UPDATE", name: "Update a form", action: %{ method: "POST", url: "http://localhost:8080/api/form/datasources/@id", parms: [ %{url_item: "@id", data_item: "id"}] } } ]
}

Repo.insert! %Datasource{
    id: 3,
    name: "Users",
    version: "1.0",
    comment: "",
    definition: %{ 
        elements: [
            %{ name: "id", type: "integer", validations: [], required: "true" },            
            %{ name: "firstname", type: "text", validations: [], required: "true" },            
            %{ name: "lastname", type: "text", validations: [], required: "true" },            
            %{ name: "email", type: "email", validations: [], required: "true" },            
            %{ name: "login", type: "text", validations: [], required: "true" },
            %{ name: "password", type: "text", validations: [], required: "true" } 
        ],
        globalValidations: [],
        restapi: ""
    },
    actions: [  %{ id: "GETALL", name: "Get all", action: %{ method: "GET", url: "http://localhost:8080/api/user/users" }, parms: [] },
                %{ id: "GET", name: "Get by id", action: %{ method: "GET", url: "http://localhost:8080/api/user/users/@id" }, parms: [ %{url_item: "@id", data_item: "id"} ] },
                %{ id: "DELETE", name: "Delete", action: %{ method: "DELETE", url: "http://localhost:8080/api/user/users/@id" }, parms: [ %{url_item: "@id", data_item: "id"} ] },
                %{ id: "CREATE", name: "Create", action: %{ method: "POST", url: "http://localhost:8080/api/user/users" }, parms: [] },
                %{ id: "UPDATE", name: "Update", action: %{ method: "POST", url: "http://localhost:8080/api/user/users/@id" }, parms: [ %{url_item: "@id", data_item: "id"}] } ]
}

Repo.insert! %Form{
    id: 1,
    name: "Form overview",
    version: "1.0",
    author: "",
    definition: %{
        type: "overview",
        title: "Form overview", 
        globalValidations: [],
        actions: [ 
            %{ id: "add", object: "FORM", action: "ADD", type: "button", label: "new"} 
        ],
        elements: [
            %{ type: "integer", datapath: "id", label: "Id" }, 
            %{ type: "text", datapath: "name", label: "Form name" }, 
            %{ type: "text", datapath: "version", label: "Version" }, 
            %{ type: "text", datapath: "author", label: "Author" }, 
            %{ type: "actions", label: "Action", items: [
                %{ action: "DELETE", object: "DATA", parm: "id", type: "button", label: "delete" },
                %{ action: "EDIT", object: "FORM", parm: "id", type: "button", label: "edit" } 
            ] } 
        ], 
        formactions: [ 
            %{ id: "EDIT", name: "Edit form", action: %{ method: "GET", url: "http://localhost:8080/admin/forms/@id", parms: [ %{url_item: "@id", data_item: "id"}] } },
            %{ id: "ADD", name: "Add form", action: %{ method: "GET", url: "http://localhost:8080//admin/forms/0", parms: [] } } 
        ]
    }
}

Repo.insert! %Form{
    id: 2,
    name: "Form detail",
    version: "1.0",
    author: "",
    definition: %{ 
        title: "Form details", 
        type: "detail",
        globalValidations: [], 
        actions: [
            %{ id: "create", object: "DATA", action: "CREATE", parm: "id", type: "button", label: "Save"},
            %{ id: "update", object: "DATA", action: "UPDATE", parm: "id", type: "button", label: "Save"},
            %{ id: "back",   object: "FORM", action: "CANCEL", type: "button", label: "Back"}
        ],
        elements: [
            %{ type: "hidden", datapath: "id"}, 
            %{ type: "text", datapath: "name", label: "Form name"}, 
            %{ type: "text", datapath: "version", label: "Version"}, 
            %{ type: "text", datapath: "author", label: "Author"}, 
            %{ type: "formdefinition", datapath: "definition", label: "Form Definition"}
        ],
        formactions: [ 
            %{ id: "CANCEL", name: "Edit form", action: %{ action: "GET", url: "http://localhost:8080/admin/forms", parms: [] } } 
        ]
    }
}

Repo.insert! %Form{
    id: 3,
    name: "User overview",
    version: "1.0",
    author: "",
    definition: %{
        title: "User overview", 
        type: "overview",
        globalValidations: [], 
        actions: [ 
            %{ id: "add", action: "ADD", object: "FORM", type: "button", label: "new"} 
        ],
        elements: [
            %{ type: "integer", datapath: "id", label: "Id" }, 
            %{ type: "text", datapath: "firstname", label: "First name" }, 
            %{ type: "text", datapath: "lastname", label: "Last name" }, 
            %{ type: "text", datapath: "login", label: "Login" }, 
            %{ type: "actions", label: "Action", items: [
                %{ action: "DELETE", object: "DATA", parm: "id", type: "button", label: "delete" },
                %{ action: "EDIT", object: "FORM", parm: "id", type: "button", label: "edit" } 
            ] } 
        ], 
        formactions: [ 
            %{ id: "EDIT", name: "Edit form", action: %{ action: "GET", url: "http://localhost:8080/admin/users/@id", parms: [ %{url_item: "@id", data_item: "id"} ] } },
            %{ id: "ADD", name: "Add form", action: %{ action: "GET", url: "http://localhost:8080//admin/users/0", parms: [] } } 
        ]
    }
}

Repo.insert! %Form{
    id: 4,
    name: "User detail",
    version: "1.0",
    author: "",
    definition: %{ 
        type: "detail",
        title: "User details", 
        globalValidations: [],
        actions: [
            %{ id: "create", action: "CREATE", object: "DATA", parm: "id", type: "button", label: "Save"},
            %{ id: "save", action: "UPDATE", object: "DATA", parm: "id", type: "button", label: "Save"},
            %{ id: "back", action: "CANCEL", object: "FORM", type: "button", label: "Back"}
        ],
        elements: [
            %{ type: "hidden", datapath: "id"}, 
            %{ type: "text", datapath: "firstname", label: "First name"}, 
            %{ type: "text", datapath: "lastname", label: "Last name"}, 
            %{ type: "text", datapath: "email", label: "Email"}, 
            %{ type: "text", datapath: "login", label: "Login"},
            %{ type: "text", datapath: "Password", label: "password"} 
        ],
        formactions: [
            %{ id: "CANCEL", name: "Cancel user edit", action: %{ action: "GET", url: "http://localhost:8080/admin/users", parms: [] } } 
        ]
    }
}
