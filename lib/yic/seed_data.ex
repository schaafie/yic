defmodule Yic.SeedData do

    def data_dd do
        %{ root: "form", datatypes: [                                                   
            %{ name: "form", basetype: "map", validations: [ %{ type: "fields",  strict: false, fields: [                                                   
                %{field: "id", required: false},                          
                %{field: "comment", required: true},                      
                %{field: "definition", required: true},                   
                %{field: "name", required: true},                         
                %{field: "version", required: true},                      
                %{field: "author", required: false} ] } ] },
            %{ basetype: "string", name: "definition", validations: [ %{ type: "fields",  strict: false, fields: [                                                   
                %{field: "action", required: false},                      
                %{field: "saveaction", required: false},                  
                %{field: "createaction", required: false},                
                %{field: "type", required: true},                         
                %{field: "elements", required: true},                     
                %{field: "title", required: true} ] } ] },
            %{basetype: "string", name: "comment", validations: []},      
            %{basetype: "number", name: "id", validations: []},           
            %{basetype: "string", name: "action", validations: []},       
            %{basetype: "string", name: "saveaction", validations: []},   
            %{basetype: "string", name: "createaction", validations: []}, 
            %{basetype: "string", name: "type", validations: []},         
            %{basetype: "array", name: "elements", validations: []},      
            %{basetype: "string", name: "title", validations: []},        
            %{basetype: "string", name: "label", validations: []},        
            %{basetype: "string", name: "name", validations: []},         
            %{ basetype: "string", name: "version", validations: [ %{ error: "Invalid version format.", rule: "^(\\d+\\.)?(\\d+\\.)?(\\*|\\d+)$", type: "format" } ]},                                                            
            %{basetype: "id", name: "author", validations: []}
        ]}                                                               
    end    

    def template_dd do
        %{ root: "template", datatypes: [                                                   
            %{ name: "template", basetype: "map", validations: [ %{ type: "fields", strict: false, fields: [                                                   
                %{field: "id", required: false},                          
                %{field: "description", required: true},                      
                %{field: "definition", required: true},                   
                %{field: "name", required: true},                         
                %{field: "version", required: true},                      
                %{field: "owner", required: false} ] } ] },
            %{ basetype: "map", name: "version", validations: [ %{ type: "fields",  strict: false, fields: [
                %{ field: "major", required: true },
                %{ field: "medior", required: true },
                %{ field: "minor", required: true },
                %{ field: "author", required: true },
                %{ field: "comment", required: true }
            ] } ] },
            %{ basetype: "string", name: "definition", validations: [] },
            %{ basetype: "string", name: "description", validations: []}, 
            %{ basetype: "number", name: "id", validations: []},           
            %{ basetype: "string", name: "name", validations: []},         
            %{ basetype: "id", name: "owner", validations: []},
            %{ basetype: "id", name: "author", validations: []},            
            %{ basetype: "number", name: "major", validations: []},           
            %{ basetype: "number", name: "medior", validations: []},           
            %{ basetype: "number", name: "minor", validations: []},           
            %{ basetype: "string", name: "comment", validations: []}         
        ]}                                                               
    end    
    

    def form_dd do
        %{ root: "form", datatypes: [ 
            %{ name: "form", basetype: "map", validations: [ %{ type: "fields",  strict: false, fields: [                                                  
                %{field: "id", required: false},                         
                %{field: "comment", required: true},                     
                %{field: "definition", required: true},                  
                %{field: "name", required: true},                        
                %{field: "version", required: true},                     
                %{field: "author", required: false} ] } ] },          
            %{ basetype: "string", name: "definition", validations: [ %{ type: "fields",  strict: false, fields: [                                                  
                %{field: "action", required: false},                     
                %{field: "saveaction", required: false},                 
                %{field: "createaction", required: false},               
                %{field: "type", required: true},                        
                %{field: "elements", required: true},                    
                %{field: "title", required: true} ] } ] },                                                           
            %{ basetype: "string", name: "comment", validations: []},
            %{basetype: "number", name: "id", validations: []},          
            %{basetype: "string", name: "action", validations: []},      
            %{basetype: "string", name: "saveaction", validations: []},  
            %{basetype: "string", name: "createaction", validations: []},
            %{basetype: "string", name: "type", validations: []},        
            %{basetype: "array", name: "elements", validations: []},     
            %{basetype: "string", name: "title", validations: []},       
            %{basetype: "string", name: "label", validations: []},       
            %{basetype: "string", name: "name", validations: []},        
            %{ basetype: "string", name: "version", validations: [%{ error: "Invalid version format.", rule: "^(\\d+\\.)?(\\d+\\.)?(\\*|\\d+)$", type: "format" }]}, 
            %{basetype: "id", name: "author", validations: []}
        ]}                                                                        
    end    
    
    def user_dd do
        %{ root: "user", datatypes: [                                                  
            %{ name: "user", basetype: "map", validations: [ %{ type: "fields",  strict: false, fields: [                                                 
                %{field: "id", required: false},                        
                %{field: "firstname", required: true},                  
                %{field: "lastname", required: true},                   
                %{field: "email", required: true}                       
            ] } ] },
            %{basetype: "string", name: "firstname", validations: []},  
            %{basetype: "number", name: "id", validations: []},         
            %{basetype: "string", name: "lastname", validations: []},   
            %{basetype: "string", name: "email", validations: []},      
            %{basetype: "string", name: "createaction", validations: []}
        ]}                                                              
    end

    def data_ofd do 
        %{ title: "Data definition overview", type: "overview", globalValidations: [], actions: [
              %{list: %{url: "apis/datadefs"}},
              %{edit: %{url: "apis/datadefs/:id"}},
              %{delete: %{url: "api/forms/datadefs/:id"}}
            ], elements: [
              %{datapath: "id", pk: true, type: "hidden"},
              %{datapath: "name", label: "Name", type: "text"},
              %{datapath: "version", label: "Version", type: "text"},
              %{datapath: "comment", label: "Comment", type: "text"}
            ],
        }
    end

    def data_dfd do 
        %{ title: "Data definition detail", type: "detail", saveaction: "/forms/datadefs/:id", 
            globalValidations: [], 
            actions: [                                                                  
              %{create: %{url: "/forms/datadefs"}},                            
              %{save: %{url: "/forms/datadefs/:id"}} ], 
            elements: [                                                                 
              %{datapath: "id", type: "hidden"},                                        
              %{ type: "tabs", elements: [                                                             
                  %{ type: "tab", label: "Generic", elements: [                                                         
                      %{ type: "grid", count: 2, elements: [                                                     
                          %{ type: "gridcol", elements: [
                              %{ datapath: "name", label: "Data definition name", type: "text" },                                                        
                              %{datapath: "version", label: "Version", type: "text"}
                            ]},                                                            
                          %{ type: "gridcol", elements: [ %{datapath: "comment", label: "Comment", type: "textarea"} ]}                                                             
                        ]}                                                                 
                    ]},                                                                   
                    %{ type: "tab", label: "Definition", elements: [ %{datapath: "definition", label: "Definition", type: "json"} ]}                                                                     
                ]}                                                                         
            ]}
    end

    def data_off do 
        %{ title: "Form overview", type: "overview", globalValidations: [],
            actions: [                                               
              %{list: %{url: "apis/forms"}},                         
              %{edit: %{url: "apis/forms/:id"}},                     
              %{delete: %{url: "api/forms/forms/:id"}} ],
            elements: [                                              
              %{datapath: "id", pk: true, type: "hidden"},           
              %{datapath: "name", label: "Name", type: "text"},      
              %{datapath: "version", label: "Version", type: "text"},
              %{datapath: "comment", label: "Comment", type: "text"} ]
          }
    end

    def data_dff do 
        %{ type: "detail", title: "Form detail", saveaction: "/forms/forms/:id", globalValidations: [],
            actions: [
              %{create: %{url: "/forms/forms"}},
              %{save: %{url: "/forms/forms/:id"}}
            ],
            elements: [
              %{datapath: "id", type: "hidden"},
              %{datapath: "name", label: "Form Name", type: "text"},
              %{datapath: "version", label: "Version", type: "text"},
              %{datapath: "comment", label: "Comment", type: "text"},
              %{datapath: "author", label: "Author", type: "number"},
              %{datapath: "definition", label: "Definition", type: "json"}
            ]
          }
    end

    def data_ofu do 
        %{ title: "User overview", type: "overview",  getaction: "apis/users", globalValidations: [],
            actions: [
                %{list: %{label: "Show users", url: "apis/users"}},
                %{edit: %{label: "Edit", url: "apis/users/:id"}},
                %{create: %{label: "New", url: "apis/users"}},
                %{delete: %{label: "Delete", url: "iam/users"}}
            ],
            elements: [
                %{datapath: "id", pk: true, type: "hidden"},
                %{datapath: "firstname", label: "First name", type: "text"},
                %{datapath: "lastname", label: "Last name", type: "text"},
                %{datapath: "email", label: "email address", type: "text"}
            ]
        }
    end

    def data_dfu do 
        %{ title: "User detail", type: "detail", saveaction: "/iam/users/:id", globalValidations: [],
            actions: [ 
                %{create: %{url: "/iam/users"}}, 
                %{save: %{url: "/iam/users/:id"}}
            ],
            elements: [
              %{datapath: "id", type: "hidden"},
              %{datapath: "firstname", label: "Fist Name", type: "text"},
              %{datapath: "lastname", label: "Last name", type: "text"},
              %{datapath: "email", label: "email address", type: "text"}
            ]
        }
    end

    # Form by Id API
    def api_fbyid do 
        %{ output: %{data: "data", datadef: "datadef", formdef: "formdef" }, actions: [
                %{ method: "get", output: "data", token: "jwt_local", url: "http://localhost:4000/api/forms/forms/:id" },
                %{ method: "get", output: "datadef", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefbyname/form" },
                %{ method: "get", output: "formdef", token: "jwt_local", url: "http://localhost:4000/api/forms/formbyname/detailsform" } ] }
    end

    # List all Users API
    def api_lau do 
        %{ output: %{data: "data", datadef: "datadef", formdef: "formdef" }, actions: [
              %{ method: "get", output: "data", token: "jwt_local", url: "http://localhost:4000/api/iam/users" },
              %{ method: "get", output: "datadef", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefbyname/user" },
              %{ method: "get", output: "formdef", token: "jwt_local", url: "http://localhost:4000/api/forms/formbyname/listuser" } ] }
    end

    # User by Id API
    def api_ubyid do 
        %{ output: %{data: "data", datadef: "datadef", formdef: "formdef" }, actions: [
              %{ method: "get", output: "data", token: "jwt_local", url: "http://localhost:4000/api/iam/users/:id" },
              %{ method: "get", output: "datadef", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefbyname/user" },
              %{ method: "get", output: "formdef", token: "jwt_local", url: "http://localhost:4000/api/forms/formbyname/detailuser" } ] }
    end

    # Datadef by Id API
    def api_ddbyid do 
        %{ output: %{data: "data", datadef: "datadef", formdef: "formdef" }, actions: [
              %{ method: "get", output: "data", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefs/:id" },
              %{ method: "get", output: "datadef", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefbyname/datadef" },
              %{ method: "get", output: "formdef", token: "jwt_local", url: "http://localhost:4000/api/forms/formbyname/detaildatadef" } ] }
    end

    # List all Users API
    def api_laf do 
        %{ output: %{data: "data", datadef: "datadef", formdef: "formdef" }, actions: [
              %{ method: "get", output: "data", token: "jwt_local", url: "http://localhost:4000/api/forms/forms" },
              %{ method: "get", output: "datadef", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefbyname/form" },
              %{ method: "get", output: "formdef", token: "jwt_local", url: "http://localhost:4000/api/forms/formbyname/listform" } ] }
    end

    # List all Users API
    def api_ladd do 
        %{ output: %{data: "data", datadef: "datadef", formdef: "formdef" }, actions: [
              %{ method: "get", output: "data", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefs" },
              %{ method: "get", output: "datadef", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefbyname/datadef" },
              %{ method: "get", output: "formdef", token: "jwt_local", url: "http://localhost:4000/api/forms/formbyname/listdatadef" } ] }
    end

end