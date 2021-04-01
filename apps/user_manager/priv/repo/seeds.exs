# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     UserManager.Repo.insert!(%UserManager.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


alias UserManager.Repo
alias UserManager.Users.User

Repo.insert! %User{
    firstname: "Pieter",
    lastname: "Schaafsma",
    email: "pieter@yic.com",
    login: "pieter",
    password: ""
}

Repo.insert! %User{
    firstname: "ad",
    lastname: "min",
    email: "admin@yic.com",
    login: "admin",
    password: ""
}

Repo.insert! %User{
    firstname: "Jort",
    lastname: "Schaafsma",
    email: "jort@yic.com",
    login: "jort",
    password: ""
}