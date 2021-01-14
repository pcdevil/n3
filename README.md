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
- **[Examples](#examples)**
  - **[Create a new project and configure package.json with sorting](#create-a-new-project-and-configure-packagejson-with-sorting)**
  - **[Setup AVA test framework and commit changes](#setup-ava-test-framework-and-commit-changes)**
  - **[Setup ESLint framework without JSDoc plugin](#setup-eslint-framework-without-jsdoc-plugin)**
- **[Tasks](#tasks)**
  - **[General purpose](#general-purpose)**
    - **[`create-editorconfig`](#create-editorconfig)**
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
- Make the entrypoint of `n³` available:
  - Method 1: Add make alias to `.bashrc` or your default shell's _runcom_ file
  - Method 2: Add to a folder listed in your `$PATH`

```bash
$ git clone git@github.com:pcdevil/n3.git ~/.n3
$ # method 1:
$ echo 'alias n3="make --makefile=~/.n3/Makefile"' >>.bashrc # .fishrc, .zshrc
$ # method 2:
$ ln -s ~/.n3/Makefile ~/bin/n3 # or any other folder already added to $PATH
```

## Usage
After the install (and opening a new interactive shell) calling the `n³` will
start the application.

The entrypoint of `n³` is a `Makefile` - this means all tasks can be chained and
the behaviour can be modifid of certain tasks via environment variables upon
calling.

## Examples

### Create a new project and configure package.json with sorting
An exhaustive example how to bootstrap a new application from the ground with
the help of `n³`:

```bash
$ # setup
$ mkdir my-awesome-project
$ cd my-awesome-project
$ git init
$ git config user.name "jakab.gipsz"
$ git config user.email "jakab.gipsz@example.org"
$ git config user.url "https://www.example.org"

$ # act
$ npm init --yes
$ n3 setup-author setup-license setup-nvm setup-package-lock sort-package-json

$ # assert
$ ls -1 --almost-all
.git
.nvmrc
package.json
package-lock.json
$ cat package.json
{
  "name": "my-awesome-project",
  "version": "1.0.0",
  "description": "",
  "keywords": [],
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "engines": {
    "node": "13.12.0"
  },
  "author": {
    "name": "jakab.gipsz",
    "email": "jakab.gipsz@example.org",
    "url": "https://www.example.org"
  },
  "license": "MIT"
}
$ git diff # inspect the modified files
$ git add .
$ git commit --message "build(my-awesome-project): initial commit"
```

### Setup AVA test framework and commit changes
In the following example you see how to specify the test framework for the
`install-test` task and replace [Mocha] with [AVA]:

```bash
$ n3 install-test TEST_FRAMEWORK=ava
$ git diff # inspect the modified files, see the ava test framework is used
$ git add .
$ git commit --message "build(ava): add test framework"
```

### Setup ESLint framework without optional stylings
While [JSDoc] can be powerful to easily create documentations of a project, it
can be undesired in certain repositories. For this reason the `install-lint`
task has an option to disable this feature:

```bash
$ n3 install-lint LINT_PLUGINS=
$ git diff # inspect the modified files, see the lack of jsdoc plugin
$ git add .
$ git commit --message "build(eslint): add linting framework"
```

## Tasks
Because of the nature of a [Makefile] all functionalities are considered as a
task and can be executed in one call after each other. This creates a very rapid
bootstrap for a new application.

### General purpose

#### `create-editorconfig`
Creates a [EditorConfig] file to make consistent styling accross the project.

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
- `type`
- `types`
- `files`
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
Installs [ESLint] as dev-dependency, and also adds [Google's config], and the
[JSDoc linting plugin] as an extension for it.

To achieve this, the task creates an `.eslintrc` config file to bootstrap and
fine-tune the config, and adds a `lint` task in the `package.json` file to run
the linter.

The default styleguide config set by `n³` is from Google with a few additional
changes on their baseline, such as tab indentation and turned off restriction on
the maximum line length. However, their config is made to be optional, and can
be turned off or replaced by the [Standard Style]. For that, simply set the
`LINT_CONFIGS` environment variable to either `google` or `standard`, and to
prevent any config installation, set it to empty string.

The JSDoc linting plugin is added in the sense to ensure better maintainability
with explained behaviour of the code and the [require-jsdoc] rule is deprecated
by **ESLint**, this plugin is needed to match the modern usage of **JSDoc**.
Similarly to the Google's config, it can be also turned off by setting the
`LINT_PLUGINS` environment variable empty.

> See **[Examples](#examples)** to see the illustration of turning off the
> optional stylings

---

#### `install-nodemon`
Installs [nodemon] as dev-dependency, and creates a basic config for it too.
Additionally it adds a `start:watch` task in the `package.json` as well.

---

#### `install-test`
Installs a test framework depending on the `TEST_FRAMEWORK` env variable:
- If the value is `ava`, then [AVA] test framework will be installed
- If the variable is not present or the value is anything else, [Mocha] with
  [Chai] assertion library, [Sinon.JS] and [sinon-chai] custom assertions
  packages will be installed

After installation, two new tasks will be created in the `package.json`: the
first one is `test` which runs the framework on files with `.spec.js` suffix
inside `test/` folder, while the second, `test:watch` will do the same but in
watch mode.

In case of Mocha, a simple setup script will be also created inside the `test/`
folder.

> See **[Examples](#examples)** to see behaviour in real life situation

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

> See **[Examples](#examples)** to see behaviour in real life situation

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
| `build` (`b`)         | `npm run build`            |
| `build-watch` (`b-w`) | `npm run build:watch`      |
| `lint` (`l`)          | `npm run lint`             |
| `start` (`s`)         | `npm start`                |
| `start-watch` (`s-w`) | `npm run start:watch`      |
| `test` (`t`)          | `npm test`                 |
| `test-watch` (`t-w`)  | `npm run test:watch`       |

## License
Available under the [MIT license](LICENSE.md).

[1]: https://github.com/tj/n
[AVA]: https://github.com/avajs/ava
[Chai]: https://www.chaijs.com/
[EditorConfig]: https://editorconfig.org/
[ESLint]: https://eslint.org/
[Git]: https://git-scm.com/
[Google's config]: https://github.com/google/eslint-config-google
[jq]: https://stedolan.github.io/jq/
[JSDoc]: https://jsdoc.app/
[JSDoc linting]: https://github.com/gajus/eslint-plugin-jsdoc
[make]: https://www.gnu.org/software/make/
[Makefile]: https://www.gnu.org/software/make/manual/make.html#Writing-Makefiles
[Mocha]: https://mochajs.org/
[Node.js]: https://nodejs.org/
[nodemon]: https://nodemon.io/
[require-jsdoc]: https://eslint.org/docs/rules/require-jsdoc#require-jsdoc-comments-require-jsdoc
[Standard Style]: https://standardjs.com/
[Sinon.JS]: https://sinonjs.org/
[sinon-chai]: https://github.com/domenic/sinon-chai
