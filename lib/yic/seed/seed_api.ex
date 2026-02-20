defmodule Yic.Seed.SeedApi do

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
    
    # FLow by Id API
    def api_flbyid do 
        %{ output: %{data: "data", datadef: "datadef", formdef: "formdef" }, actions: [
                %{ method: "get", output: "data", token: "jwt_local", url: "http://localhost:4000/api/flows/flows/:id" },
                %{ method: "get", output: "datadef", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefbyname/flow" },
                %{ method: "get", output: "formdef", token: "jwt_local", url: "http://localhost:4000/api/forms/formbyname/detailflow" } ] }
    end

    # List all FLows API
    def api_lafl do 
        %{ output: %{data: "data", datadef: "datadef", formdef: "formdef" }, actions: [
                %{ method: "get", output: "data", token: "jwt_local", url: "http://localhost:4000/api/flows/flows" },
                %{ method: "get", output: "datadef", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefbyname/flowlist" },
                %{ method: "get", output: "formdef", token: "jwt_local", url: "http://localhost:4000/api/forms/formbyname/listflow" } ] }
    end

    # Token by Id API
    def api_ftbyid do 
        %{ output: %{data: "data", datadef: "datadef", formdef: "formdef" }, actions: [
                %{ method: "get", output: "data", token: "jwt_local", url: "http://localhost:4000/api/flows/tokens/:id" },
                %{ method: "get", output: "datadef", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefbyname/token" },
                %{ method: "get", output: "formdef", token: "jwt_local", url: "http://localhost:4000/api/forms/formbyname/detailtoken" } ] }
    end

    # List all Tokens API
    def api_laft do 
        %{ output: %{data: "data", datadef: "datadef", formdef: "formdef" }, actions: [
                %{ method: "get", output: "data", token: "jwt_local", url: "http://localhost:4000/api/flows/tokens" },
                %{ method: "get", output: "datadef", token: "jwt_local", url: "http://localhost:4000/api/forms/datadefbyname/tokenlist" },
                %{ method: "get", output: "formdef", token: "jwt_local", url: "http://localhost:4000/api/forms/formbyname/listtoken" } ] }
    end

end