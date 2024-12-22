defmodule Yic.SeedData do

    # -------------------
    # Base version definition
    # -------------------

    def base_version do
        %{ major: 1, medior: 0, minor: 0, author: 1, comment: "base version" }
    end

    # -------------------
    # Data definitions
    # -------------------

    def data_dd do
        %{
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            title: "data definition schema",
            type: "object",
            description: "Schema that defines what the data definition should look like",
            required: [ "name", "definition", "version" ],
            properties: %{
                id: %{ type: "integer", description: "" },
                name: %{ type: "string", description: "" },
                comment: %{ type: "string", description: "" },
                definition: %{ 
                    type: "object", 
                    description: "Data Definition object", 
                    properties: %{},
                    required: [],
                    additionalProperties: true
                },
                version: %{
                    type: "object",
                    description: "Version object",
                    required: [ "minor", "medior", "major", "author" ],
                    properties: %{
                        minor: %{ type: "integer", description: "", minimum: 0 },
                        medior: %{ type: "integer", description: "", minimum: 0 },
                        major: %{ type: "integer", description: "", minimum: 0 },
                        author: %{ type: "integer", description: "" },
                        comment: %{ type: "string", description: "" }
                    }
                }
            }
        }

    end    

    # data list data definition - Defines the data that is shown in an overview.
    def data_ldd do
        %{
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            title: "data list object data definition schema",
            type: "array",
            description: "Schema that defines what the data list should look like",
            items: %{
                type: "object",
                properties: %{
                    id: %{ type: "integer", description: "" },
                    name: %{ type: "string", description: "" },
                    comment: %{ type: "string", description: "" },
                    definition: %{ 
                        type: "object", 
                        description: "Data Definition object", 
                        properties: %{},
                        required: [],
                        additionalProperties: true
                    },
                    version: %{
                        type: "object",
                        description: "Version object",
                        required: [ "minor", "medior", "major" ],
                        properties: %{
                            minor: %{ type: "integer", description: "", minimum: 0 },
                            medior: %{ type: "integer", description: "", minimum: 0 },
                            major: %{ type: "integer", description: "", minimum: 0 },
                            author: %{ type: "integer", description: "" },
                            comment: %{ type: "string", description: "" }
                        }
                    }    
                }
            }
        }

    end    

    def template_dd do
        %{
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            title: "Template definition schema",
            type: "object",
            description: "Schema that defines what the template definition should look like",
            required: [ "name", "definition", "version" ],
            properties: %{
                id: %{ type: "integer", description: "" },
                name: %{ type: "string", description: "" },
                description: %{ type: "string", description: "" },
                owner: %{ type: "integer", description: "" },
                definition: %{ 
                    type: "object", 
                    description: "Data Definition object", 
                    properties: %{},
                    required: [],
                    additionalProperties: true
                },
                version: %{
                    type: "object",
                    description: "Version object",
                    required: [ "minor", "medior", "major", "author" ],
                    properties: %{
                        minor: %{ type: "integer", description: "", minimum: 0 },
                        medior: %{ type: "integer", description: "", minimum: 0 },
                        major: %{ type: "integer", description: "", minimum: 0 },
                        author: %{ type: "integer", description: "" },
                        comment: %{ type: "string", description: "" }
                    }
                }
            }
        }
    end

    def item_dd do
        %{
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            title: "Content item definition schema",
            type: "object",
            description: "Schema that defines what the content item definition should look like",
            required: [ "name", "content", "version", "template", "owner" ],
            properties: %{
                id: %{ type: "integer", description: "" },
                name: %{ type: "string", description: "" },
                description: %{ type: "string", description: "" },
                owner: %{ type: "integer", description: "" },
                template: %{ type: "integer", description: "" },
                content: %{ 
                    type: "object", 
                    description: "Item content object", 
                    properties: %{},
                    required: [],
                    additionalProperties: true
                },
                version: %{
                    type: "object",
                    description: "Version object",
                    required: [ "minor", "medior", "major", "author" ],
                    properties: %{
                        minor: %{ type: "integer", description: "", minimum: 0 },
                        medior: %{ type: "integer", description: "", minimum: 0 },
                        major: %{ type: "integer", description: "", minimum: 0 },
                        author: %{ type: "integer", description: "" },
                        comment: %{ type: "string", description: "" }
                    }
                }
            }
        }
    end

    def template_ldd do
        %{
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            title: "List Template object data definition schema",
            type: "array",
            description: "Schema that defines what the template list should look like",
            items: %{
                type: "object", 
                properties: %{
                    id: %{ type: "integer", description: "" },
                    name: %{ type: "string", description: "" },
                    description: %{ type: "string", description: "" },
                    owner: %{ type: "integer", description: "" },
                    definition: %{ 
                        type: "object", 
                        description: "Data Definition object", 
                        properties: %{},
                        required: [],
                        additionalProperties: true
                    },
                    version: %{
                        type: "object",
                        description: "Version object",
                        properties: %{
                            minor: %{ type: "integer", description: "", minimum: 0 },
                            medior: %{ type: "integer", description: "", minimum: 0 },
                            major: %{ type: "integer", description: "", minimum: 0 },
                            author: %{ type: "integer", description: "" },
                            comment: %{ type: "string", description: "" }
                        }
                    }
                }
            }
        }
    end

    def item_ldd do
        %{
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            title: "List Content Item object data definition schema",
            type: "array",
            description: "Schema that defines what the content item list should look like",
            items: %{
                type: "object", 
                properties: %{
                    id: %{ type: "integer", description: "" },
                    name: %{ type: "string", description: "" },
                    description: %{ type: "string", description: "" },
                    owner: %{ type: "integer", description: "" },
                    version: %{
                        type: "object",
                        description: "Version object",
                        properties: %{
                            minor: %{ type: "integer", description: "", minimum: 0 },
                            medior: %{ type: "integer", description: "", minimum: 0 },
                            major: %{ type: "integer", description: "", minimum: 0 },
                            author: %{ type: "integer", description: "" },
                            comment: %{ type: "string", description: "" }
                        }
                    }
                }
            }
        }
    end

    def api_dd do
        %{
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            title: "API definition schema",
            type: "object",
            description: "Schema that defines what the API definition should look like",
            required: [ "name", "definition", "request", "version" ],
            properties: %{
                id: %{ type: "integer", description: "" },
                name: %{ type: "string", description: "" },
                description: %{ type: "string", description: "" },
                request: %{ type: "string", description: "" },
                definition: %{ 
                    type: "object", 
                    description: "Data Definition object", 
                    properties: %{},
                    required: [],
                    additionalProperties: true
                },
                version: %{
                    type: "object",
                    description: "Version object",
                    required: [ "minor", "medior", "major", "author" ],
                    properties: %{
                        minor: %{ type: "integer", description: "", minimum: 0 },
                        medior: %{ type: "integer", description: "", minimum: 0 },
                        major: %{ type: "integer", description: "", minimum: 0 },
                        author: %{ type: "integer", description: "" },
                        comment: %{ type: "string", description: "" }
                    }
                }
            }
        }
    end

    def api_ldd do
        %{
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            title: "API list Object data definition schema",
            type: "array",
            description: "Schema that defines what the API list should look like",
            items: %{
                type: "object",
                properties: %{
                    id: %{ type: "integer", description: "" },
                    name: %{ type: "string", description: "" },
                    request: %{ type: "string", description: "" },
                    definition: %{ 
                        type: "object", 
                        description: "Data Definition object", 
                        properties: %{},
                        required: [],
                        additionalProperties: true
                    },
                    version: %{
                        type: "object",
                        description: "Version object",
                        properties: %{
                            minor: %{ type: "integer", description: "", minimum: 0 },
                            medior: %{ type: "integer", description: "", minimum: 0 },
                            major: %{ type: "integer", description: "", minimum: 0 },
                            author: %{ type: "integer", description: "" },
                            comment: %{ type: "string", description: "" }
                        }
                    }
                }
    
            }
        }
    end
        
    def form_dd do
        %{
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            title: "Form definition schema",
            type: "object",
            description: "Schema that defines what the Form definition should look like",
            required: [ "name", "definition", "author", "version" ],
            properties: %{
                id: %{ type: "integer", description: "" },
                name: %{ type: "string", description: "" },
                comment: %{ type: "string", description: "" },
                author: %{ type: "integer", description: "" },
                definition: %{ 
                    type: "object", 
                    description: "Data Definition object", 
                    properties: %{},
                    required: [],
                    additionalProperties: true
                },
                version: %{
                    type: "object",
                    description: "Version object",
                    required: [ "minor", "medior", "major", "author" ],
                    properties: %{
                        minor: %{ type: "integer", description: "", minimum: 0 },
                        medior: %{ type: "integer", description: "", minimum: 0 },
                        major: %{ type: "integer", description: "", minimum: 0 },
                        author: %{ type: "integer", description: "" },
                        comment: %{ type: "string", description: "" }
                    }
                }
            }
        }
    end

    def form_ldd do
        %{
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            title: "Form List data definition schema",
            description: "Schema that defines what the Form List data definition should look like",
            type: "array",
            items: %{
                type: "object",
                properties: %{
                    id: %{ type: "integer", description: "" },
                    name: %{ type: "string", description: "" },
                    comment: %{ type: "string", description: "" },
                    author: %{ type: "integer", description: "" },
                    definition: %{ 
                        type: "object", 
                        description: "Data Definition object", 
                        properties: %{},
                        required: [],
                        additionalProperties: true
                    },
                    version: %{
                        type: "object",
                        description: "Version object",
                        properties: %{
                            minor: %{ type: "integer", description: "", minimum: 0 },
                            medior: %{ type: "integer", description: "", minimum: 0 },
                            major: %{ type: "integer", description: "", minimum: 0 },
                            author: %{ type: "integer", description: "" },
                            comment: %{ type: "string", description: "" }
                        }
                    }
                }
            }
        }
    end
    
    def user_dd do
        %{
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            title: "User definition schema",
            type: "object",
            description: "Schema that defines what the User data should look like",
            required: [ "firstname", "lastname", "email" ],
            properties: %{
                id: %{ type: "integer", description: "" },
                firstname: %{ type: "string", description: "" },
                lastname: %{ type: "string", description: "" },
                email: %{ type: "string", description: "" },
            }
        }
    end

    def user_ldd do
        %{
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            title: "User List data definition schema",
            description: "Schema that defines what the User List data object should look like",
            type: "array",
            items: %{
                type: "object",
                properties: %{
                    id: %{ type: "integer", description: "" },
                    firstname: %{ type: "string", description: "" },
                    lastname: %{ type: "string", description: "" },
                    email: %{ type: "string", description: "" }
                }    
            }
        }
    end

    # -------------------
    # Form definitions
    # name structure is as follows: data_<type>F<item>
    # data:     it is a data object
    # <type>    o for overview, d for detail
    # F         it is a form definition
    # <item>    the obect that it is about. d for detail, f for form etc...
    # -------------------

    def data_ofd do 
        %{ title: "Data definition overview", type: "overview", globalValidations: [], 
            actions: [
              %{list: %{url: "orchestrator/datadefs"}},
              %{edit: %{url: "orchestrator/datadefs/:id"}},
              %{delete: %{url: "api/forms/datadefs/:id"}}
            ], 
            elements: [
              %{datapath: "id", pk: true, type: "hidden"},
              %{datapath: "name", label: "Name", type: "text-only"},
              %{datapath: "version", label: "Version", type: "version-only"}
            ]
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
                              %{datapath: "version", label: "Version", type: "json"}
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
              %{list: %{url: "orchestrator/forms"}},                         
              %{edit: %{url: "orchestrator/forms/:id"}},                     
              %{delete: %{url: "api/forms/forms/:id"}} ],
            elements: [                                              
              %{datapath: "id", pk: true, type: "hidden"},           
              %{datapath: "name", label: "Name", type: "text-only"},      
              %{datapath: "version", label: "Version", type: "version-only"}
            ]
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
              %{datapath: "version", label: "Version", type: "version"},
              %{datapath: "comment", label: "Comment", type: "text"},
              %{datapath: "author", label: "Author", type: "number"},
              %{datapath: "definition", label: "Definition", type: "json"}
            ]
          }
    end

    # Content Template Overview Form
    def data_ofct do 
        %{ title: "Content template overview", type: "overview", globalValidations: [],
            actions: [                                               
              %{list: %{url: "orchestrator/contenttemplates"}},                         
              %{edit: %{url: "orchestrator/contenttemplates/:id"}},  
              %{delete: %{url: "api/contenttemplates/contenttemplates/:id"}} ],
            elements: [                                              
              %{datapath: "id", pk: true, type: "hidden"},           
              %{datapath: "name", label: "Name", type: "text-only"},      
              %{datapath: "version", label: "Version", type: "version-only"} 
            ]
          }
    end

    # Content Item Overview Form
    def data_ofci do 
        %{ title: "Content item overview", type: "overview", globalValidations: [],
            actions: [                                               
              %{list: %{url: "orchestrator/contentitems"}},                         
              %{edit: %{url: "orchestrator/contentitems/:id"}},  
              %{delete: %{url: "api/contenttemplates/contentitems/:id"}} ],
            elements: [                                              
              %{datapath: "id", pk: true, type: "hidden"},           
              %{datapath: "name", label: "Name", type: "text-only"},      
              %{datapath: "template", label: "Template", type: "number-only"},      
              %{datapath: "version", label: "Version", type: "version-only"} 
            ]
          }
    end

    # Content Template Detail Form
    def data_dfct do 
        %{ type: "detail", title: "Content template detail", saveaction: "/content/templates/:id", globalValidations: [],
            actions: [
              %{create: %{url: "/content/templates"}},
              %{save: %{url: "/content/templates/:id"}}
            ],
            elements: [
              %{datapath: "id", type: "hidden"},
              %{datapath: "name", label: "Form Name", type: "text"},
              %{datapath: "version", label: "Version", type: "json"},
              %{datapath: "comment", label: "Comment", type: "text"},
              %{datapath: "author", label: "Author", type: "number"},
              %{datapath: "definition", label: "Definition", type: "json"}
            ]
          }
    end

    # Content Item Detail Form
    def data_dfci do 
        %{ type: "detail", title: "Content item detail", saveaction: "/content/items/:id", globalValidations: [],
            actions: [
              %{create: %{url: "/content/items"}},
              %{save: %{url: "/content/items/:id"}}
            ],
            elements: [
              %{datapath: "id", type: "hidden"},
              %{datapath: "name", label: "Form Name", type: "text"},
              %{datapath: "version", label: "Version", type: "json"},
              %{datapath: "comment", label: "Comment", type: "text"},
              %{datapath: "author", label: "Author", type: "number"},
              %{datapath: "template", label: "Template", type: "number"},
              %{datapath: "content", label: "Content", type: "json"}
            ]
          }
    end

    def data_ofu do 
        %{ title: "User overview", type: "overview", globalValidations: [],
            actions: [
                %{list: %{label: "Show users", url: "orchestrator/users"}},
                %{edit: %{label: "Edit", url: "orchestrator/users/:id"}},
                %{delete: %{label: "Delete", url: "iam/users"}}
            ],
            elements: [
                %{datapath: "id", pk: true, type: "hidden"},
                %{datapath: "firstname", label: "First name", type: "text-only"},
                %{datapath: "lastname", label: "Last name", type: "text-only"},
                %{datapath: "email", label: "email address", type: "text-only"}
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

    def data_ofa do 
        %{ title: "Api overview", type: "overview", globalValidations: [],
            actions: [
                %{list: %{label: "Show apis", url: "orchestrator/apis"}},
                %{edit: %{label: "Edit", url: "orchestrator/apis/:id"}},
                %{delete: %{label: "Delete", url: "apis/apis"}}
            ],
            elements: [
                %{datapath: "id", pk: true, type: "hidden"},
                %{datapath: "name", label: "Form Name", type: "text-only"},
                %{datapath: "version", label: "Version", type: "version-only"}
              ]
        }
    end

    def data_dfa do 
        %{ title: "Api detail", type: "detail", saveaction: "/apis/apis/:id", globalValidations: [],
            actions: [ 
                %{create: %{url: "/apis/apis"}}, 
                %{save: %{url: "/apis/apis/:id"}}
            ],
            elements: [
              %{datapath: "id", type: "hidden"},
              %{datapath: "name", label: "Form Name", type: "text"},
              %{datapath: "version", label: "Version", type: "json"},
              %{datapath: "comment", label: "Comment", type: "text"},
              %{datapath: "author", label: "Author", type: "number"},
              %{datapath: "definition", label: "Definition", type: "json"}
            ]
        }
    end

    # -------------------
    # API definitions
    # -------------------

    # Form by Id API
    def api_fbyid do 
        %{ output: %{data: "data", datadef: "datadef", formdef: "formdef" }, actions: [
                %{ method: "get", output: "data", token: "jwt_local", url: "http://localhost:4000/api/forms/forms/:id" },
                %{ method: "get", output: "datadef", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefbyname/form" },
                %{ method: "get", output: "formdef", token: "jwt_local", url: "http://localhost:4000/api/forms/formbyname/detailsform" } ] }
    end

    # List all Forms API
    def api_laf do 
        %{ output: %{data: "data", datadef: "datadef", formdef: "formdef" }, actions: [
              %{ method: "get", output: "data", token: "jwt_local", url: "http://localhost:4000/api/forms/forms" },
              %{ method: "get", output: "datadef", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefbyname/formlist" },
              %{ method: "get", output: "formdef", token: "jwt_local", url: "http://localhost:4000/api/forms/formbyname/listform" } ] }
    end

    # List all Users API
    def api_lau do 
        %{ output: %{data: "data", datadef: "datadef", formdef: "formdef" }, actions: [
              %{ method: "get", output: "data", token: "jwt_local", url: "http://localhost:4000/api/iam/users" },
              %{ method: "get", output: "datadef", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefbyname/userlist" },
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

    # List all Datadefs API
    def api_ladd do 
        %{ output: %{data: "data", datadef: "datadef", formdef: "formdef" }, actions: [
              %{ method: "get", output: "data", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefs" },
              %{ method: "get", output: "datadef", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefbyname/datadeflist" },
              %{ method: "get", output: "formdef", token: "jwt_local", url: "http://localhost:4000/api/forms/formbyname/listdatadef" } ] }
    end

    # Content template by Id API
    def api_ctbyid do 
        %{ output: %{data: "data", datadef: "datadef", formdef: "formdef" }, actions: [
              %{ method: "get", output: "data", token: "jwt_local", url: "http://localhost:4000/api/content/templates/:id" },
              %{ method: "get", output: "datadef", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefbyname/contenttemplate" },
              %{ method: "get", output: "formdef", token: "jwt_local", url: "http://localhost:4000/api/forms/formbyname/detailcontenttemplate" } ] }
    end

    # Content item by Id API
    def api_cibyid do 
        %{ output: %{data: "data", datadef: "datadef", formdef: "formdef" }, actions: [
              %{ method: "get", output: "data", token: "jwt_local", url: "http://localhost:4000/api/content/items/:id" },
              %{ method: "get", output: "datadef", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefbyname/contentitem" },
              %{ method: "get", output: "formdef", token: "jwt_local", url: "http://localhost:4000/api/forms/formbyname/detailcontentitem" } ] }
    end

    # List all Content templates API
    def api_lact do 
        %{ output: %{data: "data", datadef: "datadef", formdef: "formdef" }, actions: [
              %{ method: "get", output: "data", token: "jwt_local", url: "http://localhost:4000/api/content/templates" },
              %{ method: "get", output: "datadef", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefbyname/contenttemplatelist" },
              %{ method: "get", output: "formdef", token: "jwt_local", url: "http://localhost:4000/api/forms/formbyname/listcontenttemplate" } ] }
    end
    # List all Content items API
    def api_laci do 
        %{ output: %{data: "data", datadef: "datadef", formdef: "formdef" }, actions: [
              %{ method: "get", output: "data", token: "jwt_local", url: "http://localhost:4000/api/content/items" },
              %{ method: "get", output: "datadef", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefbyname/contentitemlist" },
              %{ method: "get", output: "formdef", token: "jwt_local", url: "http://localhost:4000/api/forms/formbyname/listcontentitem" } ] }
    end

    # Api by Id API
    def api_abyid do 
        %{ output: %{data: "data", datadef: "datadef", formdef: "formdef" }, actions: [
              %{ method: "get", output: "data", token: "jwt_local", url: "http://localhost:4000/api/apis/apis/:id" },
              %{ method: "get", output: "datadef", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefbyname/api" },
              %{ method: "get", output: "formdef", token: "jwt_local", url: "http://localhost:4000/api/forms/formbyname/detailapi" } ] }
    end

    # List api templates API
    def api_laa do 
        %{ output: %{data: "data", datadef: "datadef", formdef: "formdef" }, actions: [
              %{ method: "get", output: "data", token: "jwt_local", url: "http://localhost:4000/api/apis/apis" },
              %{ method: "get", output: "datadef", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefbyname/apilist" },
              %{ method: "get", output: "formdef", token: "jwt_local", url: "http://localhost:4000/api/forms/formbyname/listapi" } ] }
    end

end