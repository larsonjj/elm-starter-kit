# Elm Starter Kit

A Starter kit for working with [Elm] and ES2015+ Javascript.

Based off the awesome work done on [elm-app-boilerplate](https://github.com/gkubisa/elm-app-boilerplate)

## Features

- automated build of all application resources using [webpack](http://webpack.github.io/)
- Hot Module Replacement for the Elm code using [elm-hot-loader](https://github.com/fluxxu/elm-hot-loader)
- automatic re-execution of tests on source change for Elm and JavaScript code
- property based testing using [elm-check](https://github.com/NoRedInk/elm-check) for the Elm tests
- Javascript test running using [ava](https://github.com/avajs/ava) 
- Javascript test coverage using [istanbul/nyc](https://github.com/istanbuljs/nyc)
- JavaScript code written in ES6, transpiled using [Babel](https://babeljs.io/)
- JavaScript linted using [eslint](http://eslint.org/)
- dependency checking using [npm-check-updates](https://github.com/tjunnone/npm-check-updates)


## Getting Started

Fork and clone this repo.

```
npm install
npm start
```

Open `http://localhost:8080/` in a browser.

For an alternative host or port run:

```
npm start -- --host=0.0.0.0 --port=8081
```

## Testing

Run tests once off:

```
npm test # Elm and JavaScript tests
npm run test:elm # only Elm tests
npm run test:js # only JavaScript tests
```

Restart the tests on code change:

```
npm run tdd # Elm and JavaScript tests
npm run tdd:elm # only Elm tests
npm run tdd:js # only JavaScript tests
```


## Deployment

The deployment is automated using Shippable and is triggered as follows:

1. Run `npm version [major|minor|patch]` on the `master` branch.
2. Add release notes in GitHub.

## Updating Version

This project customizes the standard `npm version` script to also:

- ensure that the dependencies are up to date
- execute all tests
- update the version in `elm-package.json`
- push the created tag


## Updating Dependencies

Dependency check and update is handled by [ncu](https://github.com/tjunnone/npm-check-updates). 
A check runs automatically every time `npm version` is executed but can also be triggered explicitly.

```
npm run ncu # checks the dependencies in package.json
npm run ncu -- -a # updates all dependencies in node_modules and package.json
```

Note: all `ncu` parameters and flags have to be specified after `--`.


## Elm Commands

The following Elm commands are exposed through npm scripts:

- `npm run elm`
- `npm run elm-reactor`
- `npm run elm-repl`
- `npm run elm-package`
- `npm run elm-make`

The parameters to those commands must be specified after `--`, for example: `npm run elm-package -- install evancz/elm-effects`. 
See [npm run-script](https://docs.npmjs.com/cli/run-script).


## Directory Structure

### General

- `package.json` - defines dependencies and scripts for building, testing and running the application
- `dist/` - built application artifacts produced by `npm run build`
- `.nyc_output/` - JavaScript test coverage reports

### Elm

- `elm-package.json` - describes the Elm application and its dependencies
- `elm/` - Elm source files
- `elm/Main.elm` - Elm application entry point
- `elm/App/` - the namespace for all application Elm modules
- `elm/App/Tests/` - directory containing a sample Elm test
- `elm/TestRunner.elm` - the entry point for executing tests and bootstrapping the actual test runner
- `elm/Tests.elm` - the main file loading and exposing all the test suites

### Sass

- `styles/` - all the Sass application styles

### JavaScript

- `js/` - contains all application JavaScript code
- `js/main.js` - entry point to the application JavaScript code
- `js/tests/` - directory containing a sample JavaScript test

### HTML

- `html/index.html` - overall application entry point
