---
---

REPO = window.REPO
octo = window.octo

REPO.commits.fetch({path:"color"}) (err, commit) ->
  console.log(commit)

# Option 3: using methods on the fetched Repository object
# REPO.commits.fetch({path:"color"}) (err, commit) ->
#   console.log(commit)
#   BEPO = octo.repos(commit[0].fullName).commits
#   BEPO.fetch()
#   .then (bepo) ->
#     console.log(bepo)
