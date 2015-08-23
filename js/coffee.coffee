---
---
username = window.location.host.split( '.' )[0]
repository = window.location.pathname.split( '/' )[1]

if localStorage.getItem("token")
  token = localStorage.getItem("token")
  github = new Github({
    token: token,
    auth: "oauth"
  })
  repo = github.getRepo(username, repository)
  repo.read('master', 'config.json', (err, data) ->
    config = data if !err)

console.log config
