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
commitList = document.getElementById('commits')

# If logged store `repository`, otherwise goto `login`
if localStorage.getItem("player.token")
  octo = new Octokat({ token: atob(token)})
  REPO = octo.repos(username+'/'+reponame)
  REPO.read (err, repository) ->
    if !err
      # localStorage.setItem("player.repository", JSON.stringify(repository))
      # Print `color/color.text` commits since `createdAt`
      REPO.commits.fetch({sha: "color", path: "color.txt", since: JSON.parse(repository).created_at})
        .then (commit) ->
          for own key, c of commit
            newLi = document.createElement("li")
            if key == '0'
              commitList.removeChild(commitList.firstChild)
            newLi.innerHTML = '<a href="' + c.htmlUrl + '">' + c.commit.message + '</a>';
            commitList.appendChild(newLi);
          return
    else window.location = redirect
else window.location = redirect

# Wait for color and Commit
document.getElementById("submit").addEventListener('click', (e) ->
  col = document.getElementById("body").value
  but = document.getElementById("submit")
  if col
    but.setAttribute("disabled", "true")
    # Get file sha at branch/path
    REPO.contents('color.txt').fetch({ref: 'color'})
      .then (content) ->
        # Commit color at path.sha.branch with message and base64-encoded content
        REPO.contents('color.txt').add({sha: content.sha, branch: 'color', message: col, content: btoa( col )})
          .then (commit, err) ->
            # this is not (err, bool) as stated in philschatz/octokat.js#30
            # window.location = '/' + window.location.pathname.split( '/' )[1] + '/'
            console.log commit
            # Pull Request!
        return
)
