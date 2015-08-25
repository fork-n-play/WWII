---
---
# Storage.prototype.setObj (key, obj) ->
#   return this.setItem(key, JSON.stringify(obj))
# Storage.prototype.getObj  (key) ->
#   return JSON.parse(this.getItem(key))

username = window.location.host.split( '.' )[0]
# fix for local
if username == '0'
  username = 'Fork-n-Play'
# end fix
localStorage.setItem("player.username", username)
reponame = window.location.pathname.split( '/' )[1]
localStorage.setItem("player.reponame", reponame)
redirect = '/' + reponame + '/login/'

# If logged store `repository`, otherwise goto `login`
if localStorage.getItem("player.token")
  octo = new Octokat({ token: atob(localStorage.getItem("player.token"))})
  REPO = octo.repos(username+'/'+reponame)
  REPO.fetch (err, data) ->
    if err
      window.location = redirect
      return
    else
      localStorage.setItem("player.repository", JSON.stringify(data))
      return
else window.location = redirect
