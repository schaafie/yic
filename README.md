# Yic
You're in Control: Elixir JAM Stack based web solution for 
Content, Digital Asset, Site, Form and Flow management

The main idea is that all interaction is done via an API layer.
Webpages contain web components for interaction with the server
Just as the site, the admin site will be maintained using the same principles.
Phoenix manages the API layer. The sites (including admin) will be JAM Stack based.

Mix commands for basic structure
```
mix phx.new yic
cd yic
mix ecto.create
```

Identification Authorisation Manager
```
mix phx.gen.html Iam Users users firstname:string lastname:string email:string login:string password:string --web Html.Iam
mix phx.gen.json Iam Users users firstname:string lastname:string email:string login:string password:string --web Api.Iam --no-context

mix phx.gen.html Iam Roles roles name:string description:string  --web Html.Iam
mix phx.gen.json Iam Roles roles name:string description:string  --web Api.Iam --no-context

mix phx.gen.html Iam Groups groups name:string comment:string --web Html.Iam
mix phx.gen.json Iam Groups groups name:string comment:string --web Api.Iam --no-context

mix phx.gen.html Iam System systems name:string comment:string host:string --web Html.Iam
mix phx.gen.json Iam System systems name:string comment:string host:string --web Api.Iam --no-context

mix phx.gen.html Iam Action actions name:string comment:string system_id:references:systems  url:string --web Html.Iam
mix phx.gen.json Iam Action actions name:string comment:string system_id:references:systems  url:string --web Api.Iam --no-context

mix phx.gen.html Iam Allow allows user_id:references:users role_id:references:roles group_id:references:groups action_id:references:actions --web Html.Iam
mix phx.gen.json Iam Allow allows user_id:references:users role_id:references:roles group_id:references:groups action_id:references:actions --web Api.Iam --no-context
```

Form Manager
```
mix phx.gen.html Forms Form forms name:string version:string author:references:users definition:string --web Html.Forms
mix phx.gen.json Forms Form forms name:string version:string author:references:users definition:string --web Html.Forms --no-context

mix phx.gen.html Forms Datasource datasources name:string comment:string version:string definition:string actions:array --web Html.Forms
mix phx.gen.json Forms Datasource datasources name:string comment:string version:string definition:string actions:array --web Html.Forms --no-context
```

Publication Manager
```
mix phx.gen.html Publications Pubtask pubtasks  --web Html.Forms --no-context --web Html.Publications
mix phx.gen.json Publications Pubtask pubtasks  --web Html.Forms --no-context --web Api.Publications --no-context

mix phx.gen.html Publications Pubtarget pubtargets name:string location:string type:string --web Html.Publications
mix phx.gen.json Publications Pubtarget pubtargets name:string location:string type:string --web Api.Publications --no-context

mix phx.gen.html Publications Publication publications target:references:pubtargets path:string version:string definition:string start:utc_datetime end:utc_datetime --web Html.Publications
mix phx.gen.json Publications Publication publications target:references:pubtargets path:string version:string definition:string start:utc_datetime end:utc_datetime --web Api.Publications --no-context
```


TODO:
data
versioning
content
asset
site
workflow
api