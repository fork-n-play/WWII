---
---
# var token = '',
#     config = '',
#     systemConfig = '';

# Get current gh-pages username and repository
username = window.location.host.split( '.' )[0]
repository = window.location.pathname.split( '/' )[1]

if localStorage.getItem("token")
  token = localStorage.getItem("token")
  github = new Github({
    token: token,
    auth: "oauth"
  })
  repo = github.getRepo(username, repository)
  repo.read('master', 'config.json', out = (err, data) -> if err then err else data )

console.log out
