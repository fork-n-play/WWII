---
---
username = window.location.host.split( '.' )[0]
repository = window.location.pathname.split( '/' )[1]

# fix for local
if username = '0'
  username = 'Fork-n-Play'
# end fix

octo = if localStorage.getItem("player.token") then new Octokat({
  token: atob( localStorage.getItem( "player.token" ) )
}) else window.location = '/' + repository + '/login/';

REPO = octo.repos(username+'/'+repository)

# Option 3: using methods on the fetched Repository object
REPO.forks.fetch (err, forks) ->
  console.log(forks)
  BEPO = octo.repos(forks[0].fullName).commits
  BEPO.fetch()
  .then (bepo) ->
    console.log(bepo)
