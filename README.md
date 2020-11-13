# yic
You're in Control: Elixir JAM Stack based web solution for 
Content, Digital Asset, Site, Form and Flow management

The main idea is that all interaction is done via an API layer.
Webpages contain web components for interaction with the server
Just as the site, the admin site will be maintained using the same principles.
Phoenix manages the API layer. The sites (including admin) will be JAM Stack based.

Mix commands for basic structure

```
mix phx.new yic --umbrella --app api --no-html --no-brunch --no-ecto
```

Rename the yic_umbrella to yic
Goto apps folder

```
mix phx.new user_manager --no-html --no-brunch
mix phx.gen.json Users User users firstname:string lastname:string email:string login:string password:string

mix phx.new version_manager --no-html --no-brunch

mix phx.new ia_manager --no-html --no-brunch
mix phx.gen.json Organisation Role roles name:string comment:string
mix phx.gen.json Organisation Group groupes name:string comment:string
mix phx.gen.json Tasks System systems name:string comment:string host:string
mix phx.gen.json Tasks Action actions name:string comment:string system:integer url:string
mix phx.gen.json Authorisation Allow allows user:string role:integer group:integer action:integer
mix phx.gen.json Authorisation Denie denies user:string role:integer group:integer action:integer

mix phx.new content_manager --no-html --no-brunch

mix phx.new asset_manager --no-html --no-brunch

mix phx.new site_manager --no-html --no-brunch

mix phx.new publication_manager --no-html --no-brunch

mix phx.new form_manager --no-html --no-brunch
mix phx.gen.json Forms Form forms name:string version:string author:string definition:string

mix phx.new wf_manager --no-html --no-brunch

mix phx.new api_manager --no-html --no-brunch
```