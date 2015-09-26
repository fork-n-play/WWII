---
---

username = window.location.host.split( '.' )[0]
# fix for local 0.0.0.0:4000
if username == '0'
  # local
  # username = 'petrosh'
  # remote
  username = 'Fork-n-Play'

# end fix
localStorage.setItem "player.username", username
reponame = window.location.pathname.split( '/' )[1]
localStorage.setItem "player.reponame", reponame
token = localStorage.getItem "player.token"
redirect = '/' + reponame + '/login/'
commitList = document.getElementById 'commits'

# If logged, list `color` commmits, otherwise goto `login`
if localStorage.getItem "player.token"
  octo = new Octokat { token: atob token }
  REPO = octo.repos username + '/' + reponame
  REPO.read (err, repository) ->
    if !err
      localStorage.setItem "player.repository", JSON.stringify JSON.parse repository
      # Print `color/color.text` commits since `createdAt`
      REPO.commits.fetch {sha: "color", path: "color.txt", since: JSON.parse(repository).created_at}
      .then (commessa) ->
        for own key, c of commessa
          if key == '0'
            commitList.removeChild commitList.firstChild
          if c.commit
            newLi = document.createElement "li"
            newLi.innerHTML = '<a href="' + c.htmlUrl + '">' + c.commit.message + '</a>';
            commitList.appendChild newLi;
        # if commessa.nextPage()
        #   commessa.nextPage()
        #   .then (moreCommits) ->
        #     console.log '2nd page of results', moreCommits
        #   return

      # Read config file to get root repository
      REPO.contents('config.json').fetch {ref: 'master'}
      .then (file) ->
        localStorage.setItem "player.config", atob file.content
        return
    else window.location = redirect
    return
else window.location = redirect

# Wait for color and Commit
document.getElementById("submit").addEventListener('click', (e) ->
  col = document.getElementById("body").value
  but = document.getElementById "submit"
  if col
    but.setAttribute "disabled", "true"
    # Get file sha at branch/path
    REPO.contents('color.txt').fetch {ref: 'color'}
      .then (content) ->
        # Commit color at path.sha.branch with message and base64-encoded content
        REPO.contents('color.txt').add {sha: content.sha, branch: 'color', message: col, content: btoa col}
          .then (commit, err) ->
            # this is not (err, bool) as stated in philschatz/octokat.js#30
            # window.location = '/' + window.location.pathname.split( '/' )[1] + '/'
            # Pull Request!
            config = JSON.parse localStorage.getItem "player.config"
            SREPO = octo.repos config.system.username + '/' + reponame
            SREPO.pulls.create {title:'first pull request', body: col, head: 'petrosh:color', base: 'color'}
              .then (pull) ->
                localStorage.setItem "pulls.color", pull.number
                console.log pull
            return
        return
      return
)
