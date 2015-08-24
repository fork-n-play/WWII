---
---
username = window.location.host.split( '.' )[0]
if username = '0'
  username = 'Fork-n-Play'
repository = window.location.pathname.split( '/' )[1]

octo = if localStorage.getItem("player.token") then new Octokat({
  token: localStorage.getItem("player.token")
}) else window.location = '/' + repository + '/login/';

REPO = octo.repos(username+'/'+repository)

# Option 3: using methods on the fetched Repository object
REPO.forks.fetch (err, forks) ->
  console.log(forks)
  BEPO = octo.repos(forks[0].fullName).commits
  BEPO.fetch()
  .then (bepo) ->
    console.log(bepo)
