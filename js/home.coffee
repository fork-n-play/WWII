---
---

username = localStorage.getItem("player.username")
repository = localStorage.getItem("player.repository")

octo = new Octokat({ token: atob(localStorage.getItem("player.token"))})
REPO = octo.repos(username+'/'+repository)

REPO.commits.fetch({sha:"color"}) (err, commit) ->
  if err window.location = '/' + repository + '/login/'
  console.log(commit)

# Option 3: using methods on the fetched Repository object
# REPO.commits.fetch({path:"color"}) (err, commit) ->
#   console.log(commit)
#   BEPO = octo.repos(commit[0].fullName).commits
#   BEPO.fetch()
#   .then (bepo) ->
#     console.log(bepo)
