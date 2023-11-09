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
alias Yic.SeedData

Repo.insert! %Users{ email: "admin@example.com", firstname: "ad", lastname: "ministrator" }
Repo.insert! %Account{ login: "admin", hashed_password: Pbkdf2.hash_pwd_salt("admin"), user_id: 1, confirmed_at: NaiveDateTime.local_now }

Repo.insert! %Datadef{ name: "datadef", comment: "Data definition for datadef", version: "1.0", definition: SeedData.data_dd() }
Repo.insert! %Datadef{ name: "form", comment: "Data definition for forms", version: "1.0", definition: SeedData.form_dd() }
Repo.insert! %Datadef{ name: "user", comment: "Data definition for users", version: "1.0", definition: SeedData.user_dd() }
Repo.insert! %Datadef{ name: "contenttemplate", comment: "Data definition for content template", version: "1.0", definition: SeedData.template_dd() }

Repo.insert! %Form{ name: "listdatadef", comment: "List view of all data definitions", version: "1.0", definition: SeedData.data_ofd() }    # Overview Form Data
Repo.insert! %Form{ name: "detaildatadef", comment: "Edit form for data definition", version: "1.0", definition: SeedData.data_dfd() }      # Detail Form Data
Repo.insert! %Form{ name: "listform", comment: "List view of all form defintions", version: "1.0", definition: SeedData.data_off() }
Repo.insert! %Form{ name: "detailsform", comment: "Edit view for form defintion", version: "1.0", definition: SeedData.data_dff() }
Repo.insert! %Form{ name: "listuser", comment: "list view of all user defintions", version: "1.0", definition: SeedData.data_ofu() }
Repo.insert! %Form{ name: "detailuser", comment: "Edit form for user defintion", version: "1.0", definition: SeedData.data_dfu() }

# Repo.insert! %Api{ name: "", description: "", version: "1.0", request: "", definition: "" }
Repo.insert! %Api{ name: "Show form by id", description: "Get the data for the Edit Form (data, datadef and formdef)", version: "1.0", request: "apis/forms/:id", definition: SeedData.api_fbyid() }
Repo.insert! %Api{ name: "List all users", description: "Get the data for list Users (data, datadef and formdef)", version: "1.0", request: "apis/users", definition: SeedData.api_lau() }
Repo.insert! %Api{ name: "Show user by id", description: "Get the data for the edit form (data, datadef and formdef)", version: "1.0", request: "apis/users/:id", definition: SeedData.api_ubyid() }
Repo.insert! %Api{ name: "Show datadef by id", description: "Get the data for Data def forms", version: "1.0", request: "apis/datadefs/:id", definition: SeedData.api_ddbyid() }
Repo.insert! %Api{ name: "List all forms", description: "Get the data for List Forms (data, datadef and formdef)", version: "1.0", request: "apis/forms", definition: SeedData.api_laf() }
Repo.insert! %Api{ name: "List all data definitions", description: "Get the data for List data definitions", version: "1.0", request: "apis/datadefs", definition: SeedData.api_ladd() }
