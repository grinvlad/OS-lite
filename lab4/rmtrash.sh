#!/bin/bash

if [ ! -d /home/.trash ]
then
  mkdir /home/.trash
fi

if [ ! -f /home/.trash.log ]
then
  touch /home/.trash.log
fi

if [ ! -f /home/.number_for_trash ]
then
  touch /home/.number_for_trash
  echo 1 > /home/.number_for_trash
fi

fileToDelete=$1

if [ ! -f "$fileToDelete" ]
then
  echo "file '$fileToDelete' not found"
  exit 1
fi

linkToDeletedFile=$(cat /home/.number_for_trash)
ln "$fileToDelete" /home/.trash/"$linkToDeletedFile"
echo "$(realpath "fileToDelete") $linkToDeletedFile" >> /home/.trash.log
echo $(($(cat /home/.number_for_trash) + 1)) > /home/.number_for_trash
rm "$fileToDelete"