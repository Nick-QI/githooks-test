#!/bin/sh

if  [ -d  "dist"  ]
then
rm -rf dist
git add .
git commit -m "删除上一版本本地包"
fi

branch=$(git branch | grep '*' | sed 's/* //') 
echo "当前分支 =====>> ${branch}"
echo "注意: 目前设置为 master分支下 production 模式打包, test分支下 development 模式打包"

if [ ${branch} = 'master' ]
then 
  commitText="deploy ${branch} 分支下,production模式打包部署"
  npx yarn run build:prod
else
  commitText="deploy ${branch} 分支下,development模式打包部署"
  npx yarn run build:test
fi


# cp -r buildFile/. dist/

echo $commitText $branch



git add .
git commit -m$commitText

if [ ${branch} = 'master' ]
then 
  echo 'master 分支，打tag部署===>>'
  date=$(date +%Y%m%d%H%M)
  git tag -a tag$date -m $date
  echo "当前TAG= "tag$date  
fi

