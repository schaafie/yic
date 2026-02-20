defmodule Yic.Seed.SeedData do

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
                comment: %{ type: "string", description: "" },
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
                    comment: %{ type: "string", description: "" },
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
                comment: %{ type: "string", description: "" },
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
                    comment: %{ type: "string", description: "" },
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
            required: [ "name", "definition", "owner", "version" ],
            properties: %{
                id: %{ type: "integer", description: "" },
                name: %{ type: "string", description: "" },
                comment: %{ type: "string", description: "" },
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

    def flow_dd do
        %{
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            title: "Flow definition schema",
            type: "object",
            description: "Schema that defines what the Flow data should look like",
            required: [ "name", "version", "definition", "can_start" ],
            properties: %{
                id: %{ type: "integer", description: "" },
                name: %{ type: "string", description: "" },
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
                },
                definition: %{ 
                    type: "object", 
                    description: "Data Definition object", 
                    properties: %{},
                    required: [],
                    additionalProperties: true
                },
                description: %{ type: "string", description: "" },
                can_start: %{ 
                    type: "object", 
                    description: "",
                    properties: %{},
                    required: [],
                    additionalProperties: true
                }
            }
        }
    end

    def flow_ldd do
        %{
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            title: "Flow List data definition schema",
            description: "Schema that defines what the Flow List data object should look like",
            type: "array",
            items: %{
                type: "object",
                properties: %{
                    id: %{ type: "integer", description: "" },
                    name: %{ type: "string", description: "" },
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

    def flowtoken_dd do
        %{
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            title: "Flow Task data definition schema",
            type: "object",
            description: "Schema that defines what the Flow data should look like",
            required: [ "flow_id", "can_do" ],
            properties: %{
                id: %{ type: "integer", description: "" },
                flow_id: %{ type: "integer", description: "" },
                current_task: %{ type: "string", description: ""},
                can_do: %{ 
                    type: "object", 
                    description: "",
                    properties: %{},
                    required: [],
                    additionalProperties: true
                }
            }
        }
    end

    def flowtoken_ldd do
        %{
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            title: "Flow Task List data definition schema",
            description: "Schema that defines what the Flow List data object should look like",
            type: "array",
            items: %{
                type: "object",
                properties: %{
                    id: %{ type: "integer", description: "" },
                    flow_id: %{ type: "integer", description: "" },
                    current_task: %{ type: "string", description: ""}
                }    
            }
        }
    end

end