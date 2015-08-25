---
---

username = window.location.host.split( '.' )[0]
repository = window.location.pathname.split( '/' )[1]

# fix for local
if username == '0'
  username = 'Fork-n-Play'
# end fix

if localStorage.getItem("player.token")
  octo = new Octokat({ token: atob(localStorage.getItem("player.token"))})
  window.REPO = REPO = octo.repos(username+'/'+repository)
  REPO.fetch (err, data) ->
    if err
      window.location = '/' + repository + '/login/'
      return
    else
      localStorage.setItem("player.repository", JSON.stringify(data))
else window.location = '/' + repository + '/login/'
