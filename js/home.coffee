---
---

username = localStorage.getItem("player.username")
reponame = localStorage.getItem("player.reponame")
repository = JSON.parse(localStorage.getItem("player.repository"))
commitList = document.getElementById("commits")

octo = new Octokat({ token: atob(localStorage.getItem("player.token"))})
REPO = octo.repos(username+'/'+reponame)

# Print `color/color.json` commits since `createdAt`
REPO.commits.fetch({sha: "color", path: "color.json", since: repository.createdAt})
  .then (commit) ->
    commitList.removeChild(commitList.firstChild)
    for c in commit
      newLi = document.createElement("li")
      newLi.innerHTML = '<a href="' + c.html_url + '">' + c.commit.message + '</a>';
      commitList.appendChild(newLi);
    return

# Wait for color
document.getElementById("submit").addEventListener('click', (e) ->
  col = document.getElementById("body").value
  but = document.getElementById("submit")
  json = JSON.stringify({"color": col })
  if col
    but.setAttribute("disabled", "true")
    REPO.contents('color.json').fetch({ref: 'color'})
      .then (content) ->
        localStorage.setItem('sha.color',content.sha)
        REPO.contents('color.json').add({sha: content.sha, branch: 'color', message: json, content: btoa( json )})
          .then (commit, err) ->
            # this is not (err, bool) as stated in philschatz/octokat.js#30
             window.location = '/' + window.location.pathname.split( '/' )[1] + '/'
        return
)

# Option 3: using methods on the fetched Repository object
# REPO.commits.fetch({path:"color"}) (err, commit) ->
#   console.log(commit)
#   BEPO = octo.repos(commit[0].fullName).commits
#   BEPO.fetch()
#   .then (bepo) ->
#     console.log(bepo)
