# WWII

- World War II – Player repository
- World War II - [System repository](https://github.com/Fork-n-Play/WWII-system)

## Scripts

- [philschatz/octokat.js](https://github.com/philschatz/octokat.js)
  - [example.md](https://github.com/philschatz/octokat.js/blob/afde38c4bf20423dc51215816047277c003cac14/examples.md)

- [nodeca/js-yaml](https://github.com/nodeca/js-yaml) parser and dumper  
  ```coffee
  REPO.contents('_config.yaml').fetch {ref: 'gh-pages'}
  .then (yml) ->
    a = jsyaml.load atob yml.content
    for i of a
      console.log i, a[i] # key, value
    console.log jsyaml.dump a # referse to yml
    return
  ```

## Setup

Refer to [petrosh/autoCommit](https://github.com/petrosh/autoCommit)

1. Fork this repository.
2. Choose a player name and insert in [name.txt](../../edit/gh-pages/name.txt) (must be in gh-pages).
3. Create a [personal token](https://github.com/settings/tokens) and copy it.
4. Head to `<YOUR_USERNAME>.github.io/WWII` and paste the token.
5. Done

## Flow

1. Read `config.json` and data
2. Read `system` config, scripts, tables
3. Input actions
4. Commit changes and open a Pull request on `system/branch`

## Thanks to

- http://www.regexr.com/
- https://somafm.com/fluid/
