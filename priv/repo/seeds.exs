# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Yic.Repo.insert!(%Yic.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Yic.Repo
alias Yic.Iam.Users
alias Yic.Iam.Account
alias Yic.Forms.Form
alias Yic.Apis.Api

Repo.insert! %Users{
    email: "admin@example.com",
    firstname: "ad",
    lastname: "ministrator",
}

Repo.insert! %Account{
  login: "admin",
  hashed_password: Pbkdf2.hash_pwd_salt("admin"),
  user_id: 1,
  confirmed_at: NaiveDateTime.local_now
}

Repo.insert! %Form{
  name: "listform",
  comment: "List view of all forms",
  version: "1.0",
  definition: "{
    \"action\": \"apis/forms\",
    \"type\": \"overview\",
    \"elements\": [
    { \"datapath\": \"id\", \"type\": \"hidden\", \"pk\": true },
    { \"datapath\": \"name\", \"label": "Name", \"type\": \"text\" },
    { \"datapath\": \"version\", \"label\": \"Version\", \"type\": \"text\" },
    { \"datapath\": \"comment\", \"label\": \"Comment", \"type\": \"text\" }
    ],
    \"globalValidations\": [],
    \"title\": \"Form overview\"
  }"
}

Repo.insert! %Form{
  name: "detailsform",
  comment: "Edit view for forms",
  version: "1.0",
  definition: "{
    \"action\": \"/forms/forms/:id\",
    \"type\": \"detail\",
    \"elements\": [
    { \"datapath\": \"id\", \"type\": \"hidden\" },
    { \"datapath\": \"name\", \"label": "Form Name", \"type\": \"text\" },
    { \"datapath\": \"version\", \"label\": \"Version\", \"type\": \"text\" },
    { \"datapath\": \"comment\", \"label\": \"Comment", \"type\": \"text\" },
    { \"datapath\": \"author\", \"label\": \"Author", \"type\": \"number\" },
    { \"datapath\": \"definition\", \"label\": \"Definition", \"type\": \"json\" }
    ],
    \"globalValidations\": [],
    \"title\": \"Form detail\"
  }"
}

Repo.insert! %Api{ 
  name: "List all forms",
  description: "Get the data for List Forms (data, datadef & formdef)".
  version: "0.1",
  request: "apis/forms",
  definition: "{
    \"actions\": [
      {\"url\": \"http://localhost:4000/api/forms/forms\", \"method\": \"get\", \"token\": \"jwt_local\", \"output\": \"data\"},
      {\"url\": \"http://localhost:4000/api/forms/datadef\", \"method\": \"get\", \"token\": \"jwt_local\", \"output\": \"datadef\"},
      {\"url\": \"http://localhost:4000/api/forms/byname/listform\", \"method\": \"get\", \"token\": \"jwt_local\", \"output\": \"formdef\"}
    ],
    \"output\": {
      \"data\": \"data\",
      \"datadef\": \"datadef\",
      \"formdef\": \"formdef\"
    }
  }"
}

Repo.insert! %Api{ 
  name: "Show form by id",
  description: "Get the data for the Edit Form (data, datadef & formdef)".
  version: "0.1",
  request: "apis/forms/:id",
  definition: "{ 
    \"actions\": [ 
      {\"url\": \"http://localhost:4000/api/forms/forms/:id\", \"method\": \"get\", \"token\": \"jwt_local\", \"outpu\t": \"data\"}, 
      {\"url\": \"http://localhost:4000/api/forms/datadef\", \"method\": \"get\", \"token": \"jwt_local", \"output\": \"datadef\"}, 
      {\"url\": \"http://localhost:4000/api/forms/byname/detailsform\", \"method\": \"get\", \"token\": \"jwt_local\", \"output\": \"formdef\"} 
    ], 
    \"output\": { 
      \"data\": \"data\", 
      \"datadef\": \"datadef\", 
      \"formdef\": \"formdef\" 
    } 
  }"
}