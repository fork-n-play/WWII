var token = '';

// Get current gh-pages username and reponame
var pathArray = window.location.host.split( '.' );
var pathSlash = window.location.pathname.split( '/' ); // pathSlash[1]
var username = pathArray[0];
var reponame = pathSlash[1];
// root index.html url is '/'+reponame

// Check if token is stored
if( localStorage.getItem("token") !== null ){
  // Retrieve token from localStorage
  token = localStorage.getItem("token");
  // OAuth
  var github = new Github({
    token: token,
    auth: "oauth"
  });
  // Read repository
  var repo = github.getRepo(username, reponame);
  repo.read('master', 'config.json', function(err, data) {
    if(err===null){
      localStorage.setItem("config",data);
      // Append system in div
      document.getElementById("config").value = JSON.parse(data).system;
      // Read `name.txt` commits
      readCommits(repo);
    }else{
      // Display error and remove token from localStorage
      document.getElementsByTagName('section')[0].innerHTML = '<h1>error '+err.error+'</h1><a href="/'+reponame+'">Again</a>';
      localStorage.removeItem('token');
    }
  });
  // Submit handler
  document.getElementById("submit").addEventListener("click",function(){
    // Disable submit button
    document.getElementById('submit').setAttribute("disabled", "true");
    // Retrieve textarea content
    body = document.getElementById("body").value;
    // Write on master branch
    repo.write('master', 'data/name.txt', body, 'committed '+new Date(), function(err, sha) {
      if(err===null){
        // Success
        document.getElementsByTagName('section')[0].innerHTML = '<h1>Commit ok</h1><h2>sha '+sha+'</h2><a href="/'+reponame+'">Again</a>';
      }else{
        // Error, remove token
        localStorage.removeItem('token');
        document.getElementsByTagName('section')[0].innerHTML = '<h1>error '+err.error+'</h1><a href="/'+reponame+'">Again</a>';
      }
    });
  },false);
}else{
  window.location = '/'+reponame+'/login/';
}
function readCommits(repo){
  // Read commits
  repo.getCommits({sha:'master', path:'data/name.txt'}, function(err, data){
    if(err===null){
      // Commits loop
      commitList = document.getElementById("commits");
      Object.keys(data).forEach(function(key,index){
        if(index === 0) commitList.removeChild(commitList.firstChild);
        // Create list item, populate and append
        newLi = document.createElement("li");
        newLi.innerHTML = '<a href="'+data[key].html_url+'">'+data[key].commit.message+'</a>';
        commitList.appendChild(newLi);
      });
      // Append name in textarea
      document.getElementById("body").value = data;
    }else console.log(err);
  });
}
