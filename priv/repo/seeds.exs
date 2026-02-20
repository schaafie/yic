# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#

alias Yic.Repo
alias Yic.Iam.Users
alias Yic.Iam.Account
alias Yic.Forms.Datadef
alias Yic.Forms.Form
alias Yic.Apis.Api
alias Yic.Seed.SeedData
alias Yic.Seed.SeedForm
alias Yic.Seed.SeedApi

Repo.insert! %Users{ email: "admin@example.com", firstname: "ad", lastname: "ministrator" }
Repo.insert! %Account{ login: "admin", hashed_password: Pbkdf2.hash_pwd_salt("admin"), user_id: 1, confirmed_at: NaiveDateTime.local_now }

Repo.insert! %Datadef{ name: "form", comment: "Data definition for forms", version: SeedData.base_version(), definition: SeedData.form_dd() }
Repo.insert! %Datadef{ name: "user", comment: "Data definition for users", version: SeedData.base_version(), definition: SeedData.user_dd() }
Repo.insert! %Datadef{ name: "datadef", comment: "Data definition for datadef", version: SeedData.base_version(), definition: SeedData.data_dd() }
Repo.insert! %Datadef{ name: "contenttemplate", comment: "Data definition for content template", version: SeedData.base_version(), definition: SeedData.template_dd() }
Repo.insert! %Datadef{ name: "contentitem", comment: "Data definition for content items", version: SeedData.base_version(), definition: SeedData.item_dd() }
Repo.insert! %Datadef{ name: "api", comment: "Data definition for apis", version: SeedData.base_version(), definition: SeedData.api_dd() }
Repo.insert! %Datadef{ name: "flow", comment: "Data definition for flow", version: SeedData.base_version(), definition: SeedData.flow_dd() }
Repo.insert! %Datadef{ name: "token", comment: "Data definition for token", version: SeedData.base_version(), definition: SeedData.flowtoken_dd() }

Repo.insert! %Datadef{ name: "formlist", comment: "Data definition for list of forms", version: SeedData.base_version(), definition: SeedData.form_ldd() }
Repo.insert! %Datadef{ name: "userlist", comment: "Data definition for list of users", version: SeedData.base_version(), definition: SeedData.user_ldd() }
Repo.insert! %Datadef{ name: "datadeflist", comment: "Data definition for list of data definitions", version: SeedData.base_version(), definition: SeedData.data_ldd() }
Repo.insert! %Datadef{ name: "contenttemplatelist", comment: "Data definition for list of content templates", version: SeedData.base_version(), definition: SeedData.template_ldd() }
Repo.insert! %Datadef{ name: "contentitemlist", comment: "Data definition for list of content items", version: SeedData.base_version(), definition: SeedData.item_ldd() }
Repo.insert! %Datadef{ name: "apilist", comment: "Data definition for list of apis", version: SeedData.base_version(), definition: SeedData.api_ldd() }
Repo.insert! %Datadef{ name: "flowlist", comment: "Data definition for list of flows", version: SeedData.base_version(), definition: SeedData.flow_ldd() }
Repo.insert! %Datadef{ name: "tokenlist", comment: "Data definition for list of tokens", version: SeedData.base_version(), definition: SeedData.flowtoken_ldd() }

Repo.insert! %Form{ name: "listform", owner: 1, comment: "List view of all form defintions", version: SeedData.base_version(), definition: SeedForm.data_off() }
Repo.insert! %Form{ name: "detailsform", owner: 1, comment: "Edit view for form defintion", version: SeedData.base_version(), definition: SeedForm.data_dff() }
Repo.insert! %Form{ name: "listuser", owner: 1, comment: "List view of all user defintions", version: SeedData.base_version(), definition: SeedForm.data_ofu() }
Repo.insert! %Form{ name: "detailuser", owner: 1, comment: "Edit form for user defintion", version: SeedData.base_version(), definition: SeedForm.data_dfu() }
Repo.insert! %Form{ name: "listdatadef", owner: 1, comment: "List view of all data definitions", version: SeedData.base_version(), definition: SeedForm.data_ofd() }    # Overview Form Data
Repo.insert! %Form{ name: "detaildatadef", owner: 1, comment: "Edit form for data definition", version: SeedData.base_version(), definition: SeedForm.data_dfd() }      # Detail Form Data
Repo.insert! %Form{ name: "listcontenttemplate", owner: 1, comment: "List view of all content template defintions", version: SeedData.base_version(), definition: SeedForm.data_ofct() }
Repo.insert! %Form{ name: "detailcontenttemplate", owner: 1, comment: "Edit form for content template defintion", version: SeedData.base_version(), definition: SeedForm.data_dfct() }
Repo.insert! %Form{ name: "listcontentitem", comment: "List view of all content item defintions", version: SeedData.base_version(), definition: SeedForm.data_ofci() }
Repo.insert! %Form{ name: "detailcontentitem", comment: "Edit form for content item defintion", version: SeedData.base_version(), definition: SeedForm.data_dfci() }
Repo.insert! %Form{ name: "listapi", owner: 1, comment: "List view of all api defintions", version: SeedData.base_version(), definition: SeedForm.data_ofa() }
Repo.insert! %Form{ name: "detailapi", owner: 1, comment: "Edit form for api defintion", version: SeedData.base_version(), definition: SeedForm.data_dfa() }
Repo.insert! %Form{ name: "listflow", owner: 1, comment: "List view of all api defintions", version: SeedData.base_version(), definition: SeedForm.data_offl() }
Repo.insert! %Form{ name: "detailflow", owner: 1, comment: "Edit form for api defintion", version: SeedData.base_version(), definition: SeedForm.data_dffl() }
Repo.insert! %Form{ name: "listtoken", owner: 1, comment: "List view of all api defintions", version: SeedData.base_version(), definition: SeedForm.data_offt() }
Repo.insert! %Form{ name: "detailtoken", owner: 1, comment: "Edit form for api defintion", version: SeedData.base_version(), definition: SeedForm.data_dfft() }

Repo.insert! %Api{ name: "List all forms", description: "Get the data for List Forms (data, datadef and formdef)", version: SeedData.base_version(), request: "forms", definition: SeedApi.api_laf() }
Repo.insert! %Api{ name: "Show form by id", description: "Get the data for the Edit Form (data, datadef and formdef)", version: SeedData.base_version(), request: "forms/:id", definition: SeedApi.api_fbyid() }
Repo.insert! %Api{ name: "List all users", description: "Get the data for list Users (data, datadef and formdef)", version: SeedData.base_version(), request: "users", definition: SeedApi.api_lau() }
Repo.insert! %Api{ name: "Show user by id", description: "Get the data for the edit form (data, datadef and formdef)", version: SeedData.base_version(), request: "users/:id", definition: SeedApi.api_ubyid() }
Repo.insert! %Api{ name: "List all data definitions", description: "Get the data for List data definitions", version: SeedData.base_version(), request: "datadefs", definition: SeedApi.api_ladd() }
Repo.insert! %Api{ name: "Show data definition by id", description: "Get the data for Data def forms", version: SeedData.base_version(), request: "datadefs/:id", definition: SeedApi.api_ddbyid() }
Repo.insert! %Api{ name: "List all content template definitions", description: "Get the data for List content template definitions", version: SeedData.base_version(), request: "contenttemplates", definition: SeedApi.api_lact() }
Repo.insert! %Api{ name: "Show content template definition by id", description: "Get the data for content template forms", version: SeedData.base_version(), request: "contenttemplates/:id", definition: SeedApi.api_ctbyid() }
Repo.insert! %Api{ name: "List all content item definitions", description: "Get the data for List content item definitions", version: SeedData.base_version(), request: "contentitems", definition: SeedApi.api_laci() }
Repo.insert! %Api{ name: "Show content item definition by id", description: "Get the data for content item forms", version: SeedData.base_version(), request: "contentitems/:id", definition: SeedApi.api_cibyid() }
Repo.insert! %Api{ name: "List all api definitions", description: "Get the data for List api definitions", version: SeedData.base_version(), request: "apis", definition: SeedApi.api_laa() }
Repo.insert! %Api{ name: "Show api definition by id", description: "Get the data for api forms", version: SeedData.base_version(), request: "apis/:id", definition: SeedApi.api_abyid() }
