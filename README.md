# Yic
You're in Control: Elixir JAM Stack based web solution for Content, Digital Asset, Site, Form and Flow management

The main idea is that all interaction is (ultimately) done via an API layer. There will be a basic phoenix html layer to start with, in the end, this will be superfluous. Web pages interact with the backend using frontend html/javascript, preferably web-components. Just as the site, the admin site will be maintained using the same principles. This way it will be possible to maintain your admin layer as well as your (public) site.

# Build with
Erts 10.7 OTP 22
Elixir 1.12.3
Phoenix 1.2.5

# Usage
The framework is in development. Thus it is not enough to start the server. 
You need to add basic credentials as well otherwise there will be token errors in accessing the application.
In dev and Test default tokens are inserted as part of the init of the token registry.

To start server (in interactive mode):
```
$ iex -S mix phx.server
``` 

Open browser and go to:
1. http://localhost:4000/index.html for API based admin front end
2. http://localhost:4000/html/iam/accounts/log_in for traditional Phoenix based admin front end 

# Commands for basic structure
This section will be moved later to a wiki page. For now I will leave this here for development purposes.

```
mix phx.new yic
cd yic
mix ecto.create
```

1. Identification Authorisation Manager

For the authentication manager we will use phx.gen.auth to start with and add Guardian for the API layer.
The default mechanisme of self registration and identification with the email adress I will change. The login will be done using login, not email and password.

```
mix phx.gen.auth Iam Account accounts --web Html.Iam

mix phx.gen.html Iam User users firstname:string lastname:string email:string --web Html.Iam
mix phx.gen.json Iam User users firstname:string lastname:string email:string --web Api.Iam --no-context

mix phx.gen.html Iam Role roles name:string description:string  --web Html.Iam
mix phx.gen.json Iam Role roles name:string description:string  --web Api.Iam --no-context

mix phx.gen.html Iam Group groups name:string comment:string --web Html.Iam
mix phx.gen.json Iam Group groups name:string comment:string --web Api.Iam --no-context

mix phx.gen.html Iam System systems name:string comment:string host:string --web Html.Iam
mix phx.gen.json Iam System systems name:string comment:string host:string --web Api.Iam --no-context

mix phx.gen.html Iam Action actions name:string comment:string system_id:references:systems  url:string --web Html.Iam
mix phx.gen.json Iam Action actions name:string comment:string system_id:references:systems  url:string --web Api.Iam --no-context

mix phx.gen.html Iam Allow allows account_id:references:accounts role_id:references:roles group_id:references:groups action_id:references:actions --web Html.Iam
mix phx.gen.json Iam Allow allows account_id:references:accounts role_id:references:roles group_id:references:groups action_id:references:actions --web Api.Iam --no-context

mix phx.gen.html Iam Denie denies account_id:references:accounts role_id:references:roles group_id:references:groups action_id:references:actions --web Html.Iam
mix phx.gen.json Iam Denie denies account_id:references:accounts role_id:references:roles group_id:references:groups action_id:references:actions --web Api.Iam --no-context
```

2. Form Manager
```
mix phx.gen.html Forms Form forms name:string comment:string version:map author:references:users definition:map --web Html.Forms
mix phx.gen.json Forms Form forms name:string comment:string version:map author:references:users definition:map --web Api.Forms --no-context

mix phx.gen.html Forms Datasource datasources name:string comment:string version:map definition:map actions:array:string --web Html.Forms
mix phx.gen.json Forms Datasource datasources name:string comment:string version:map definition:map actions:array:string --web Api.Forms --no-context

mix phx.gen.html Forms Datadef datadefs name:string comment:string version:map definition:map --web Html.Forms
mix phx.gen.json Forms Datadef datadefs name:string comment:string version:map definition:map --web Api.Forms --no-context

mix phx.gen.html Forms Dataelement dataelements name:string comment:string version:map definition:map actions:array:string --web Html.Forms
mix phx.gen.json Forms Dataelement dataelements name:string comment:string version:map definition:map actions:array:string --web Api.Forms --no-context
```

6. Content Manager
```
mix phx.gen.html Content Template templates name:string description:string owner:references:users version:map definition:map --web Html.Content
mix phx.gen.json Content Template templates name:string description:string owner:references:users version:map definition:map --web Api.Content --no-context

mix phx.gen.html Content Item items --web Api.Content name:string description:string owner:references:users version:map content:map --web Html.Content
mix phx.gen.json Content Item items --web Api.Content name:string description:string owner:references:users version:map content:map --web Api.Content --no-context
```

4. Api Manager
```
mix phx.gen.html Apis Api apis name:string description:string version:map request:string definition:map --web Html.Apis
mix phx.gen.json Apis Api apis name:string description:string version:map request:string definition:map --web Api.Apis --no-context
```

5. Publication Manager
```
mix phx.gen.html Publications Pubtask pubtasks name:string version:map definition:map --web Html.Publications
mix phx.gen.json Publications Pubtask pubtasks name:string version:map definition:map --web Api.Publications --no-context

mix phx.gen.html Publications Pubtarget pubtargets name:string version:map type:string definition:map --web Html.Publications
mix phx.gen.json Publications Pubtarget pubtargets name:string version:map type:string definition:map --web Api.Publications --no-context

mix phx.gen.html Publications Pubresult pubresults  --web Html.Publications
mix phx.gen.json Publications Pubresult pubresults  --web Api.Publications --no-context

mix phx.gen.html Publications Publication publications target:references:pubtargets path:string version:map definition:map start:utc_datetime end:utc_datetime --web Html.Publications
mix phx.gen.json Publications Publication publications target:references:pubtargets path:string version:map definition:map start:utc_datetime end:utc_datetime --web Api.Publications --no-context
```

6. workflow

The workflow works as follows. A flow is defined as a template. 
When the flow is started, a token will be created based on the template. As soon as the flow is waiting to be continued,
a task is created so not all tokens have to be queried to get the tasks that a (system)user can perform.

```
mix phx.gen.html Flows Flow flows name:string description:string version:map definition:map can_start:map --web Html.Flows
mix phx.gen.json Flows Flow flows name:string description:string version:map definition:map can_start:map --web Flow.Flows --no-context

mix phx.gen.html Flows Token tokens flow_id:references:flows owner:references:users token:map --web Html.Tokens
mix phx.gen.json Flows Token tokens flow_id:references:flows owner:references:users token:map --web Flow.Tokens --no-context

mix phx.gen.html Flows Task tasks flow_id:references:flows can_do:map --web Html.Tasks
mix phx.gen.json Flows Task tasks flow_id:references:flows can_do:map --web Flow.Tasks --no-context
```

TODO:

7. asset

8. data

9. site

10. versioning

