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
  - **[General purpose](#general-purpose)**
    - **[`help`](#help)**
    - **[`sort-package-json`](#sort-package-json)**
  - **[Install related](#install-related)**
    - **[`install-lint`](#install-lint)**
    - **[`install-nodemon`](#install-nodemon)**
    - **[`install-test`](#install-test)**
  - **[Setup related](#setup-related)**
    - **[`setup`](#setup)**
    - **[`setup-author`](#setup-author)**
    - **[`setup-license`](#setup-license)**
    - **[`setup-nvm`](#setup-nvm)**
    - **[`setup-package-lock`](#setup-package-lock)**
    - **[`setup-start`](#setup-start)**
  - **[npm related](#npm-related)**
- **[License](#license)**

## Prerequires
To use it make sure the following application are installed on the system:
- [Git]
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

The entrypoint of `n3` is a `Makefile` - this means all tasks can be chained and
the behaviour can be modifid of certain tasks via environment variables upon
calling.

## Tasks
Because of the nature of a [Makefile] all functionalities are considered as a
task and can be executed in one call after each other. This creates a very rapid
bootstrap for a new application.

### General purpose

#### `help`
Prints the available tasks with a brief description next to them.

This is the **default task**, which means it will run if no task is given to
`n³`.

---

#### `sort-package-json`
While some tasks modifies the `package.json`, they always put the new content at
the end of the config. This tasks sorts the keys to a more organised way to make
the json more readable.

When combined with other tasks, the order matters and therefore it is adviced to
put this task at the end of the list.

The order of the keys:
- `name`
- `version`
- `description`
- `keywords`
- `main`
- `bin`
- `exports` _(all subkeys will be sorted in alphabet order)_
- `scripts` _(all subkeys will be sorted in alphabet order)_
- `engines`
- `private`
- `author`
- `contributors`
- `repository`
- `bugs`
- `homepage`
- `license`
- `devDependencies`
- `peerDependencies`
- `dependencies`
- **_any other key in alphabet order_**

If a listed property is not present then it won't be added to the new list, and
similarly, if an existing property has only `null` value it will be discarded.

### Install related

#### `install-lint`
Installs [ESLint] and [Google's config] as dev-dependency. Creates an
`.eslintrc` config file to bootstrap and fine-tune the config and it also adds a
`lint` task in the `package.json` file to run the linter.

---

#### `install-nodemon`
Installs [nodemon] as dev-dependency, and creates a basic config for it too.
Additionally it adds a `start:watch` task in the `package.json` as well.

---

#### `install-test`
Installs the [Mocha] test framework, [Chai] assertion library, [Sinon.JS]
mocking library along with [sinon-chai] custom assertions to bundle them
together.

A simple setup script will be created also inside the `test/` folder, and two
task will be created in the `package.json`: the first one is `test` which runs
the mocha framework including the setup and with the files inside `test/` folder
with `.spec.js` suffix, and the second one is `test:watch` which does the same
but in watch mode.

### Setup related

#### `setup`
This tasks act as a shorthand: it runs all available setup tasks (listed
bellow).

---

#### `setup-author`
Sets the author inside the `package.json`. There are three available information
to be determined: _name_, _email_ and _url_ - by default the task invokes
**Git** to get them from the user config, but with the `AUTHOR_NAME`,
`AUTHOR_EMAIL`, `AUTHOR_URL` env variables all can be overwritten.

While the `user.url` is not a standard **Git** configuration key, there is no
disadvantage setting it and using for this scenario.

If a **Git** config (or env) variable is empty then it will be skipped from the
author property.

##### Example
```bash
$ git config user.name "jakab.gipsz"
$ git config user.email "jakab.gipsz@example.org"
$ git config user.url "https://www.example.org"
$
$ n3 setup-author
$ cat package.json
# ...
  "author": {
    "name": "jakab.gipsz",
    "email": "jakab.gipsz@example.org",
    "url": "https://www.example.org"
  }
}
$
```

---

#### `setup-license`
Sets the license in the `package.json`. By default, this will be _"MIT"_, but
can be overwritten by `LICENSE` env variable.

---

#### `setup-nvm`
Populates a `.nvmrc` file with the a **Node.js** version and stricts the engine
version in the `package.json` too.

By default, the current version will be used (determined with the `node
--version` command), but this can be overwritten with the `NODE_VERSION` env
variable.

---

#### `setup-package-lock`
Creates an empty(ish) `package-lock.json` file to accompany the `package.json`.

---

#### `setup-start`
Sets the start script inside the `package.json` to run the `main` entrypoint of
the project with **Node.js**.

---

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
[Git]: https://git-scm.com/
[Google's config]: https://github.com/google/eslint-config-google
[jq]: https://stedolan.github.io/jq/
[make]: https://www.gnu.org/software/make/
[Makefile]: https://www.gnu.org/software/make/manual/make.html#Writing-Makefiles
[Mocha]: https://mochajs.org/
[Node.js]: https://nodejs.org/
[nodemon]: https://nodemon.io/
[Sinon.JS]: https://sinonjs.org/
[sinon-chai]: https://github.com/domenic/sinon-chai
