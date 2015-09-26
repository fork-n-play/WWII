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
console.log jsyaml.load("---\n
# Collection Types #############################################################\n
################################################################################\n
\n
# http://yaml.org/type/map.html -----------------------------------------------#\n
\n
map:\n
  # Unordered set of key: value pairs.\n
  Block style: !!map\n
    Clark : Evans\n
    Ingy  : döt Net\n
    Oren  : Ben-Kiki\n
  Flow style: !!map { Clark: Evans, Ingy: döt Net, Oren: Ben-Kiki }\n
\n
# http://yaml.org/type/omap.html ----------------------------------------------#\n
\n
omap:\n
  # Explicitly typed ordered map (dictionary).\n
  Bestiary: !!omap\n
    - aardvark: African pig-like ant eater. Ugly.\n
    - anteater: South-American ant eater. Two species.\n
    - anaconda: South-American constrictor snake. Scaly.\n
    # Etc.\n
  # Flow style\n
  Numbers: !!omap [ one: 1, two: 2, three : 3 ]\n
\n
# http://yaml.org/type/pairs.html ---------------------------------------------#\n
\n
pairs:\n
  # Explicitly typed pairs.\n
  Block tasks: !!pairs\n
    - meeting: with team.\n
    - meeting: with boss.\n
    - break: lunch.\n
    - meeting: with client.\n
  Flow tasks: !!pairs [ meeting: with team, meeting: with boss ]\n
\n
# http://yaml.org/type/set.html -----------------------------------------------#\n
\n
set:\n
  # Explicitly typed set.\n
  baseball players: !!set\n
    ? Mark McGwire\n
    ? Sammy Sosa\n
    ? Ken Griffey\n
  # Flow style\n
  baseball teams: !!set { Boston Red Sox, Detroit Tigers, New York Yankees }\n
\n
# http://yaml.org/type/seq.html -----------------------------------------------#\n
\n
seq:\n
  # Ordered sequence of nodes\n
  Block style: !!seq\n
  - Mercury   # Rotates - no light/dark sides.\n
  - Venus     # Deadliest. Aptly named.\n
  - Earth     # Mostly dirt.\n
  - Mars      # Seems empty.\n
  - Jupiter   # The king.\n
  - Saturn    # Pretty.\n
  - Uranus    # Where the sun hardly shines.\n
  - Neptune   # Boring. No rings.\n
  - Pluto     # You call this a planet?\n
  Flow style: !!seq [ Mercury, Venus, Earth, Mars,      # Rocks\n
                      Jupiter, Saturn, Uranus, Neptune, # Gas\n
                      Pluto ]                           # Overrated\n
\n
\n
# Scalar Types #################################################################\n
################################################################################\n
\n
# http://yaml.org/type/bool.html ----------------------------------------------#\n
\n
bool:\n
  - true\n
  - True\n
  - TRUE\n
  - false\n
  - False\n
  - FALSE\n
\n
# http://yaml.org/type/float.html ---------------------------------------------#\n
\n
float:\n
  canonical: 6.8523015e+5\n
  exponentioal: 685.230_15e+03\n
  fixed: 685_230.15\n
  sexagesimal: 190:20:30.15\n
  negative infinity: -.inf\n
  not a number: .NaN\n
\n
# http://yaml.org/type/int.html -----------------------------------------------#\n
\n
int:\n
  canonical: 685230\n
  decimal: +685_230\n
  octal: 02472256\n
  hexadecimal: 0x_0A_74_AE\n
  binary: 0b1010_0111_0100_1010_1110\n
  sexagesimal: 190:20:30\n
\n
# http://yaml.org/type/merge.html ---------------------------------------------#\n
\n
merge:\n
  - &CENTER { x: 1, y: 2 }\n
  - &LEFT { x: 0, y: 2 }\n
  - &BIG { r: 10 }\n
  - &SMALL { r: 1 }\n
  \n
  # All the following maps are equal:\n
  \n
  - # Explicit keys\n
    x: 1\n
    y: 2\n
    r: 10\n
    label: nothing\n
\n
# http://yaml.org/type/null.html ----------------------------------------------#\n
\n
null:\n
  # This mapping has four keys,\n
  # one has a value.\n
  empty:\n
  canonical: ~\n
  english: null\n
  ~: null key\n
  # This sequence has five\n
  # entries, two have values.\n
  sparse:\n
    - ~\n
    - 2nd entry\n
    -\n
    - 4th entry\n
    - Null\n
\n
# http://yaml.org/type/str.html -----------------------------------------------#\n
\n
string: abcd\n
\n
# http://yaml.org/type/timestamp.html -----------------------------------------#\n
\n
timestamp:\n
  canonical:        2001-12-15T02:59:43.1Z\n
  valid iso8601:    2001-12-14t21:59:43.10-05:00\n
  space separated:  2001-12-14 21:59:43.10 -5\n
  no time zone (Z): 2001-12-15 2:59:43.10\n
  date (00:00:00Z): 2002-12-14\n
\n
\n
# JavaScript Specific Types ####################################################\n
################################################################################\n
\n
# https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/RegExp\n
\n
regexp:\n
  simple: !!js/regexp      foobar\n
  modifiers: !!js/regexp   /foobar/mi\n
\n
# https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/undefined\n
\n
undefined: !!js/undefined ~\n
\n
# https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Function\n
\n
#function: !!js/function >\n
#  function foobar() {\n
#    return 'Wow! JS-YAML Rocks!';\n
#  }\n
\n
\n
# Custom types #################################################################\n
################################################################################\n
\n
\n
# JS-YAML allows you to specify a custom YAML types for your structures.\n
# This is a simple example of custom constructor defined in `js/demo.js` for\n
# custom `!sexy` type:\n
#\n
# var SexyYamlType = new jsyaml.Type('!sexy', {\n
#   kind: 'sequence',\n
#   construct: function (data) {\n
#     return data.map(function (string) { return 'sexy ' + string; });\n
#   }\n
# });\n
#\n
# var SEXY_SCHEMA = jsyaml.Schema.create([ SexyYamlType ]);\n
#\n
# result = jsyaml.load(yourData, { schema: SEXY_SCHEMA });\n
\n
#foobar: !sexy\n
#  - bunny\n
#  - chocolate\n
");
REPO.contents('_config.yaml').fetch {ref: 'gh-pages'}
.then (cson) ->
  console.log  cson
  # a = atob cson.content
  # b = a.replace /---\n/g, ""
  # c = CoffeeScript.compile b, { bare: "on" }
  # console.log c.getValue()
  # console.log CoffeeScript.compile atob cson.content
  # console.log CSON.stringify CoffeeScript.compile atob cson.content
  return

REPO.contents('example.yml').fetch {ref: 'gh-pages'}
.then (cson) ->
  console.log atob cson.content
  return
