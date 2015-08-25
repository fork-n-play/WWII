---
---

REPO = window.REPO

# Option 3: using methods on the fetched Repository object
REPO.commits.fetch({path:"setup"}) (err, commit) ->
  console.log(commit)
  BEPO = octo.repos(forks[0].fullName).commits
  BEPO.fetch()
  .then (bepo) ->
    console.log(bepo)
