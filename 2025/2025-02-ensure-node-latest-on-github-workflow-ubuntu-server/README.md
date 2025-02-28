# ensure node latest on github workflow ubuntu server

## contents

- [ensure node latest on github workflow ubuntu server](#ensure-node-latest-on-github-workflow-ubuntu-server)
  - [contents](#contents)
  - [introduction](#introduction)
  - [run the workflow with a linux server](#run-the-workflow-with-a-linux-server)
  - [create github actions/workflow folder](#create-github-actionsworkflow-folder)
  - [build yaml script](#build-yaml-script)
  - [add in bash script](#add-in-bash-script)

## introduction

if you are using github actions to run a script, sometimes you will just want to ensure you have the latest versions of node and npm running

let's look how to accomplish this

## run the workflow with a linux server

create a github repository https://github.com/your-user-name/repository-name

clone it on your machine

```bash
git clone https://github.com/your-user-name/repository-name
```

## create github actions/workflow folder

in the root create the folder structure

```bash
mkdir .github
cd .github
mkdir workflows
cd workflows
touch update-node-to-latest.yml
```

## build yaml script

```yml
name: update-node-to-latest
run-name: update-node-to-latest
on: [push]
jobs:
  update-node-to-latest:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20.18.3'
      - run: echo ${{ github.actor }} 
      - run: echo update node to latest
      - run: pwd 
      - run: ls
```

## add in bash script

```yml
      - run: chmod +x update-node-to-latest.sh
      - run: update-node-to-latest.sh
```

```bash
echo " "
echo "========================================"
echo "            check and update node       "
echo "========================================"

echo " "
echo "node -v"
node -v
echo "npm -v"
npm -v
echo "npm install -g npm@latest"
npm install -g npm@latest
echo " "
echo "node -v"
node -v
echo "npm -v"
npm -v
```

