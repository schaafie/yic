# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PublicationManager.Repo.insert!(%PublicationManager.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias PublicationManager.Repo
alias PublicationManager.Publications.Publication

Repo.insert! %Publication{
    target: 1,
    path:  "/admin/users",
    version:  "1.0",
    definition: %{
        menu: %{
            topMenu: [
                %{url: "/admin/users", title: "Users"}, 
                %{url: "/admin/forms", title: "Forms"}, 
                %{url: "/admin/content", title: "Content"}, 
                %{url: "/admin/flows", title: "Flows"}], 
            contextMenu: []}, 
        main: %{
            datapath: "/user/users", 
            datadefpath: "/form/datasources/3", 
            pageelementpath: "/form/forms/3",
            data: [],
            datadef: %{}, 
            pageelement: %{}
        }
    }
}

Repo.insert! %Publication{
    target: 1,
    path:  "/admin/forms",
    version:  "1.0",
    definition: %{
        menu: %{
            topMenu: [
                %{url: "/admin/users", title: "Users"}, 
                %{url: "/admin/forms", title: "Forms"}, 
                %{url: "/admin/content", title: "Content"}, 
                %{url: "/admin/flows", title: "Flows"}], 
            contextMenu: []}, 
        main: %{
            datapath: "/form/forms", 
            datadefpath: "/form/datasources/1", 
            pageelementpath: "/form/forms/1",
            data: [],
            datadef: %{}, 
            pageelement: %{}
        }
    }
}

Repo.insert! %Publication{
    target: 1,
    path:  "/admin/users/@id",
    version:  "1.0",    
    definition: %{
        menu: %{
            topMenu: [
                %{url: "/admin/users", title: "Users"}, 
                %{url: "/admin/forms", title: "Forms"}, 
                %{url: "/admin/content", title: "Content"}, 
                %{url: "/admin/flows", title: "Flows"}], 
            contextMenu: []}, 
        main: %{
            datapath: "/user/users/@id", 
            datadefpath: "/form/datasources/3", 
            pageelementpath: "/form/forms/4",
            data: %{},
            datadef: %{},
            pageelement: %{}
        }
    }
}

Repo.insert! %Publication{
    target: 1,
    path: "/admin/forms/@id",
    version: "1.0",
    definition: %{ 
        menu: %{
            topMenu: [
                %{url: "/admin/users", title: "Users"}, 
                %{url: "/admin/forms", title: "Forms"}, 
                %{url: "/admin/content", title: "Content"}, 
                %{url: "/admin/flows", title: "Flows"}
            ], 
            contextMenu: []
        }, 
        main: %{
            datapath: "/form/forms/@id", 
            datadefpath: "/form/datasources/1", 
            pageelementpath: "/form/forms/2",
            data: %{},
            datadef: %{}, 
            pageelement: %{}
        }
    }
}