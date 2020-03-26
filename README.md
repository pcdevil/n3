# n³
`n³` (pronounced `/ˈen ˈkjuːb/`) is a collection of little scripts to bootstrap
new **Node.js** projects and make my (and hopefully others 🙂) life easier with
automating certain repetitive tasks.

#### What does n³ stand for?
Initially I named the project `n`, but I quickly realised there is already a
[Node.js version manager with that name][1]. Although the next item in the
series would be `n2`, I liked the sound of `n³` more and decided to just go with
this solution.

## Table of Contents
- **[Prerequires](#prerequires)**
- **[Installation](#installation)**
- **[Usage](#usage)**
- **[Tasks](#tasks)**
  - **[General purposes](#general-purposes)**
    - **[`help`](#help)**
  - **[Install related](#install-related)**
    - **[`install-lint`](#install-lint)**
    - **[`install-nodemon`](#install-nodemon)**
    - **[`install-test`](#install-test)**
  - **[npm related](#npm-related)**
- **[License](#license)**

## Prerequires
To use it make sure the following application are installed on the system:
- [git] (for install)
- [make]
- [Node.js]
- [jq]

## Installation
Use the following steps to install it:
- Clone the repository
- Add make alias to `.bashrc` or your default shell's _runcom_ file

```bash
$ git clone git@github.com:pcdevil/n3.git ~/.n3
$ echo 'alias n3="make --makefile=~/.n3/Makefile"' >>.bashrc # .fishrc, .zshrc
```

## Usage
After the install (and opening a new interactive shell) calling the `n3` will
start the application.


## Tasks
Because of the nature of a [Makefile] all functionalities are considered as a
task and can be executed in one call after each other. This creates a very rapid
bootstrap for a new application.

### General purposes

#### `help`
Prints the available tasks with a brief description next to them.

This is the **default task**, which means it will run if no task is given to
`n³`.

### Install related

#### `install-lint`
Installs [ESLint] and [Google's config] as dev-dependency. Creates an
`.eslintrc` config file to bootstrap and fine-tune the config and it also adds a
`lint` task in the `package.json` file to run the linter.

#### `install-nodemon`
Installs [nodemon] as dev-dependency, and creates a basic config for it too.
Additionally it adds a `start:watch` task in the `package.json` as well.

#### `install-test`
Installs the [Mocha] test framework, [Chai] assertion library, [Sinon.JS]
mocking library along with [sinon-chai] custom assertions to bundle them
together.

A simple setup script will be created also inside the `test/` folder, and two
task will be created in the `package.json`: the first one is `test` which runs
the mocha framework including the setup and with the files inside `test/` folder
with `.spec.js` suffix, and the second one is `test:watch` which does the same
but in watch mode.

### npm related
While the main goal of `n³` is to help with a project start, it also provides
shortcuts to most commonly used **npm** tasks. They all act as aliases and don't
alter the behaviour.

Below you can see the list of the tasks:

| Task name (alias)     | Equivalent **npm** command |
| --------------------- | -------------------------- |
| `lint` (`l`)          | `npm run lint`             |
| `start` (`s`)         | `npm start`                |
| `start-watch` (`s-w`) | `npm run start:watch`      |
| `test` (`t`)          | `npm test`                 |
| `test-watch` (`t-w`)  | `npm run test:watch`       |

## License
Available under the [MIT license](LICENSE.md).

[1]: https://github.com/tj/n
[Chai]: https://www.chaijs.com/
[ESLint]: https://eslint.org/
[git]: https://git-scm.com/
[Google's config]: https://github.com/google/eslint-config-google
[jq]: https://stedolan.github.io/jq/
[make]: https://www.gnu.org/software/make/
[Makefile]: https://www.gnu.org/software/make/manual/make.html#Writing-Makefiles
[Mocha]: https://mochajs.org/
[Node.js]: https://nodejs.org/
[nodemon]: https://nodemon.io/
[Sinon.JS]: https://sinonjs.org/
[sinon-chai]: https://github.com/domenic/sinon-chai
