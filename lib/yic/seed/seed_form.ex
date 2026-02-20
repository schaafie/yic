defmodule Yic.Seed.SeedForm do

    # -------------------
    # Form definitions
    # name structure is as follows: data_<type>F<item>
    # data:     it is a data object
    # <type>    o for overview, d for detail
    # F         it is a form definition
    # <item>    the obect that it is about. d for data, f for form, ct for content template etc...
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
        %{ title: "Form detail", type: "detail", saveaction: "/forms/forms/:id", globalValidations: [],
            actions: [
              %{create: %{url: "/forms/forms"}},
              %{save: %{url: "/forms/forms/:id"}}
            ],
            elements: [
              %{datapath: "id", type: "hidden"},
              %{datapath: "name", label: "Form Name", type: "text"},
              %{datapath: "version", label: "Version", type: "version"},
              %{datapath: "comment", label: "Comment", type: "text"},
              %{datapath: "owner", label: "Owner", type: "select", source: "/iam/users", value: "id", display: ["firstname", "lastname"] },
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
              %{delete: %{url: "/content/templates/:id"}} ],
            elements: [                                              
              %{datapath: "id", pk: true, type: "hidden"},           
              %{datapath: "name", label: "Name", type: "text-only"},      
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
              %{datapath: "version", label: "Version", type: "version"},
              %{datapath: "comment", label: "Comment", type: "text"},
              %{datapath: "owner", label: "Owner", type: "select", source: "/iam/users", value: "id", display: ["firstname", "lastname"] },
              %{datapath: "definition", label: "Definition", type: "json"}
            ]
          }
    end

    # Content Item Overview Form
    def data_ofci do 
        %{ title: "Content item overview", type: "overview", globalValidations: [],
            actions: [                                               
              %{list: %{url: "orchestrator/contentitems"}},                         
              %{edit: %{url: "orchestrator/contentitems/:id"}},  
              %{delete: %{url: "/content/items/:id"}} ],
            elements: [                                              
              %{datapath: "id", pk: true, type: "hidden"},           
              %{datapath: "name", label: "Name", type: "text-only"},      
              %{datapath: "template", label: "Template", type: "number-only"},      
              %{datapath: "version", label: "Version", type: "version-only"} 
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
              %{datapath: "version", label: "Version", type: "version"},
              %{datapath: "comment", label: "Comment", type: "text"},
              %{datapath: "owner", label: "Owner", type: "select", source: "/iam/users", value: "id", display: ["firstname", "lastname"] },
              %{datapath: "template", label: "Template", type: "number"},
              %{datapath: "content", label: "Content", type: "json"}
            ]
          }
    end

    # User overview form
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

    # User detail form
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

    # API overview form
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

    # API detail form
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
              %{datapath: "owner", label: "Owner", type: "select", source: "/iam/users", value: "id", display: ["firstname", "lastname"] },
              %{datapath: "definition", label: "Definition", type: "json"}
            ]
        }
    end

    # FLOW overview form
    def data_offl do 
        %{ title: "Flow overview", type: "overview", globalValidations: [],
            actions: [
                %{list: %{label: "Show apis", url: "orchestrator/flows"}},
                %{edit: %{label: "Edit", url: "orchestrator/flows/:id"}},
                %{delete: %{label: "Delete", url: "flows/flows"}}
            ],
            elements: [
                %{datapath: "id", pk: true, type: "hidden"},
                %{datapath: "name", label: "Name ", type: "text-only"},
                %{datapath: "version", label: "Version", type: "version-only"}
              ]
        }
    end

    # FLOW detail form
    def data_dffl do 
        %{ title: "Flow detail", type: "detail", saveaction: "/flows/flows/:id", globalValidations: [],
            actions: [ 
                %{create: %{url: "/flows/flows"}}, 
                %{save: %{url: "/flows/flows/:id"}}
            ],
            elements: [
              %{datapath: "id", type: "hidden"},
              %{datapath: "name", label: "Flow Name", type: "text"},
              %{datapath: "version", label: "Version", type: "version"},
              %{datapath: "description", label: "Comment", type: "text"},
              %{datapath: "can_start", label: "Can Start", type: "json"},
              %{datapath: "definition", label: "Definition", type: "json"}
            ]
        }
    end

    # Flow Token overview form
    def data_offt do 
        %{ title: "Flow Token overview", type: "overview", globalValidations: [],
            actions: [
                %{list: %{label: "Show apis", url: "orchestrator/tokens"}},
                %{edit: %{label: "Edit", url: "orchestrator/tokens/:id"}},
                %{delete: %{label: "Delete", url: "flows/tokens"}}
            ],
            elements: [
                %{datapath: "id", pk: true, type: "hidden"},
                %{datapath: "token_id", label: "Token Id", type: "integer"},
                %{datapath: "current_task", label: "Current Task", type: "version-only"}
              ]
        }
    end

    # Flow Token detail form
    def data_dfft do 
        %{ title: "Flow token detail", type: "detail", saveaction: "/flows/tokens/:id", globalValidations: [],
            actions: [ 
                %{create: %{url: "/flows/tokens"}}, 
                %{save: %{url: "/flows/tokens/:id"}}
            ],
            elements: [
              %{datapath: "id", type: "hidden"},
              %{datapath: "flow_id", label: "Flow Id", type: "integer"},
              %{datapath: "current_task", label: "Current Task", type: "text-only"},
              %{datapath: "can_do", label: "Can do", type: "json"}
            ]
        }
    end
    
end