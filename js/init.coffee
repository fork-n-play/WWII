---
---

username = window.location.host.split( '.' )[0]
localStorage.setItem("player.username", username)
repository = window.location.pathname.split( '/' )[1]
localStorage.setItem("player.repository", repository)

# fix for local
if username == '0'
  username = 'Fork-n-Play'
# end fix

if localStorage.getItem("player.token")
  octo = new Octokat({ token: atob(localStorage.getItem("player.token"))})
  REPO = octo.repos(username+'/'+repository)
  REPO.fetch (err, data) ->
    if err
      window.location = '/' + repository + '/login/'
      return
    else
      localStorage.setItem("player.repository", JSON.stringify(data))
else window.location = '/' + repository + '/login/'
