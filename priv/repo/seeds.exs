# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Project.Repo.insert!(%Project.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Project.Repo
alias Project.Users.User

pwhash = Argon2.hash_pwd_salt("alicepassword")
pwhash2 = Argon2.hash_pwd_salt("bobpassword")



Repo.insert!(%User{email: "alice@example.com", name: "Alice", password_hash: pwhash})
Repo.insert!(%User{email: "bob@example.com", name: "Bob", password_hash: pwhash2})

