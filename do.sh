#!/bin/sh

addGitCommit() {
  git add .
  git commit -m '${1} dist 打包'
}

branch=$(git branch | grep '*' | sed 's/* //') 

echo ${branch}

if [ ${branch} = 'master' ]
then 
  echo 'master 生产打包'
  yarn run build:prod
  cd ./dist
  touch prod.txt
  addGitCommit ${branch}
else
  echo 'test 打包'
  yarn run build:test
  cd ./dist
  touch test.txt
  addGitCommit ${branch}
fi
