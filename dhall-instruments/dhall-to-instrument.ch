#!/bin/bash

fullfile="$1"
filename=$(basename -- "$fullfile")
jsonfile="${filename}.json"
zipfile="${filename}.zip"

dhall-to-json --file "${fullfile}" --preserve-null > $jsonfile

echo "redcap.ispm.unibe.ch" > OriginID.txt

/*json2csv from npm install -g json2csv*/
json2csv -i $jsonfile -o instrument.csv

zip $zipfile  instrument.csv OriginID.txt

rm OriginID.txt
