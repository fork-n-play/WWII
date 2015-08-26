---
---

username = window.location.host.split( '.' )[0]
# fix for local
if username == '0'
  username = 'petrosh'
# end fix
localStorage.setItem("player.username", username)
reponame = window.location.pathname.split( '/' )[1]
localStorage.setItem("player.reponame", reponame)
token = localStorage.getItem("player.token")
redirect = '/' + reponame + '/login/'

# If logged store `repository`, otherwise goto `login`
if localStorage.getItem("player.token")
  octo = new Octokat({ token: atob(token)})
  REPO = octo.repos(username+'/'+reponame)
  REPO.fetch (err, data) ->
    if !err
      localStorage.setItem("player.repository", JSON.stringify(data))
    else window.location = redirect
else window.location = redirect

# Print `color/color.json` commits since `createdAt`
REPO.commits.fetch({sha: "color", path: "color.json", since: repository.createdAt})
  .then (commit) ->
    commitList.removeChild(commitList.firstChild)
    for c in commit
      newLi = document.createElement("li")
      newLi.innerHTML = '<a href="' + c.html_url + '">' + c.commit.message + '</a>';
      commitList.appendChild(newLi);
    return

# Wait for color and Commit
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
