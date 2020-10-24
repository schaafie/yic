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
mix phx.new.ecto db
mix new version_manager --sup
mix new user_manager --sup
mix new api_manager --sup
mix new iam --sup
mix new content_manager --sup
mix new asset_manager --sup
mix new site_manager --sup
mix new publisher --sup
mix new wf_manager --sup
mix new form_manager --sup
```
