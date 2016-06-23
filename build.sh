#!/usr/bin/env bash

./node_modules/.bin/coffee ./build/build.coffee

versionRe='[0-9]+\.[0-9]+'
defaultVersion='0.10.22'

for folder in $(ls -d dist/*/*)
do
  pushd $(pwd) > /dev/null
  cd ./$folder
  for version in $(ls -d *)
  do
    if [ ! -f $version/Dockerfile ]; then
      rm -rf $folder/$version
      continue
    fi

    if [ $version == $defaultVersion ]; then
      baseVersion='default'
    else
      [[ $version =~ $versionRe ]] && baseVersion=${BASH_REMATCH[0]}
    fi
    mv ./$version ./$baseVersion
  done
  popd > /dev/null
done
