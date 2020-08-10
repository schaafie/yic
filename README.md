# yic
You're in Control: Elixir JAM Stack based web solution for Content, Site, Asset en Flow management

Mix commands for basic structure
```
mix phx.new yic --umbrella --app yic --no-brunch --no-ecto
```
Rename the yic_umbrella to yic
```
cd yic/apps
mix phx.new.ecto db
mix new version_manager
mix new user_manager
mix new api_manager
mix new iam
mix new cms
mix new asset_manager
mix new site_manager
mix new publisher
mix new wfm
mix new form_manager
```
