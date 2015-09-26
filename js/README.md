---
---
Reconverted

- `_config.yaml`

```
name: WWII-player repository
title: WWII player
description: Distribuited World War II a la Wolfenstein on top of Fork-n-Play
scripts:
  - octokat
  - esprima
  - js-yaml
styles:
  - style
excerpt_separator: |+



exclude: []
sass:
  sass_dir: _scss
  style: ':compressed'
highlighter: pygments
markdown: kramdown
kramdown:
  auto_ids: true
baseurl: /WWII
permalink: pretty
relative_permalinks: true
```

- `example.yml`

```
map:
  Block style:
    Clark: Evans
    Ingy: dÃ¶t Net
    Oren: Ben-Kiki
  Flow style:
    Clark: Evans
    Ingy: dÃ¶t Net
    Oren: Ben-Kiki
omap:
  Bestiary:
    - aardvark: African pig-like ant eater. Ugly.
    - anteater: South-American ant eater. Two species.
    - anaconda: South-American constrictor snake. Scaly.
  Numbers:
    - one: 1
    - two: 2
    - three: 3
pairs:
  Block tasks:
    - - meeting
      - with team.
    - - meeting
      - with boss.
    - - break
      - lunch.
    - - meeting
      - with client.
  Flow tasks:
    - - meeting
      - with team
    - - meeting
      - with boss
set:
  baseball players:
    Mark McGwire: null
    Sammy Sosa: null
    Ken Griffey: null
  baseball teams:
    Boston Red Sox: null
    Detroit Tigers: null
    New York Yankees: null
seq:
  Block style:
    - Mercury
    - Venus
    - Earth
    - Mars
    - Jupiter
    - Saturn
    - Uranus
    - Neptune
    - Pluto
  Flow style:
    - Mercury
    - Venus
    - Earth
    - Mars
    - Jupiter
    - Saturn
    - Uranus
    - Neptune
    - Pluto
bool:
  - true
  - true
  - true
  - false
  - false
  - false
float:
  canonical: 685230.15
  exponentioal: 685230.15
  fixed: 685230.15
  sexagesimal: 685230.15
  negative infinity: -.inf
  not a number: .nan
int:
  canonical: 685230
  decimal: 685230
  octal: 685230
  hexadecimal: 685230
  binary: 685230
  sexagesimal: 685230
merge:
  - x: 1
    'y': 2
  - x: 0
    'y': 2
  - r: 10
  - r: 1
  - x: 1
    'y': 2
    r: 10
    label: nothing
'null':
  empty: null
  canonical: null
  english: null
  'null': null key
  sparse:
    - null
    - 2nd entry
    - null
    - 4th entry
    - null
string: abcd
timestamp:
  canonical: 2001-12-15T02:59:43.100Z
  valid iso8601: 2001-12-15T02:59:43.100Z
  space separated: 2001-12-15T02:59:43.100Z
  no time zone (Z): 2001-12-15T02:59:43.100Z
  'date (00:00:00Z)': 2002-12-14T00:00:00.000Z
regexp:
  simple: !<tag:yaml.org,2002:js/regexp> /foobar/
  modifiers: !<tag:yaml.org,2002:js/regexp> /foobar/mi
undefined: !<tag:yaml.org,2002:js/undefined> ''
```
