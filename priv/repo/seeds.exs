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