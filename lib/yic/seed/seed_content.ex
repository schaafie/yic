defmodule Yic.Seed.SeedData do

    def ct_link do
        %{
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            title: "CT link item",
            type: "object",
            description: "Content template for link item",
            required: [ "name", "url", "alttext" ],
            properties: %{
                name: %{ type: "string", description: "" },
                title: %{ type: "string", description: "" },
                url: %{ type: "string", format: "url", description: "" },
                alttext: %{ type: "string", description: "" }
            }
        }
    end

    def ct_image do
        %{
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            title: "CT image item",
            type: "object",
            description: "Content template for image item",
            required: [ "name", "src", "alttext" ],
            properties: %{
                name: %{ type: "string", description: "" },
                src: %{ type: "string", format: "url", description: "" },
                alttext: %{ type: "string", description: "" }
            }
        }
    end

    def ct_text_only do
        %{
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            title: "CT text only item",
            type: "string",
            description: "Content template for text only part"
        }
    end

    def ct_rich_text do
        %{
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            title: "CT rich text item",
            type: "array",
            description: "Content template for rich text",
            anyOf: [
                %{ type: "string" },
                %{ "$ref": "#/$defs/image" },
                %{ "$ref": "#/$defs/link" }
            ],
            "$defs": %{
                image: %{
                    type: "object",
                    required: [ "name", "src", "alttext" ],
                    properties: %{
                        name: %{ type: "string", description: "" },
                        src: %{ type: "string", format: "url", description: "" },
                        alttext: %{ type: "string", description: "" }
                    }                    
                },
                link: %{
                    type: "object",
                    required: [ "name", "url", "alttext" ],
                    properties: %{
                        name: %{ type: "string", description: "" },
                        title: %{ type: "string", description: "" },
                        url: %{ type: "string", format: "url", description: "" },
                        alttext: %{ type: "string", description: "" }
                    }
                }
            }

        }
    end


end