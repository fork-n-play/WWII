// Personal token not stored
var token = '';

// Get current gh-pages username and reponame
var pathArray = window.location.host.split( '.' );
var pathSlash = window.location.pathname.split( '/' ); // pathSlash[1]
var username = pathArray[0];
var reponame = pathSlash[1];
// root index.html url is '/'+reponame

// Submit handler
document.getElementById("submit").addEventListener("click",function(){
  var val = document.getElementById("token").value;
  if( val !== '' ){
    // Disable submit button
    document.getElementById('submit').setAttribute("disabled", "true");
    // Store token in localStorage and reload page
    localStorage.setItem("token", document.getElementById("token").value);
    window.location = '/' + reponame;
  }
},false);
