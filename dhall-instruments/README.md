### Living systematic review on the effects of the COVID-19 pandemic on the general populations' mental health, alcohol/substance abuse and violence

### [Dhall-REDCap api](https://github.com/esm-ispm-unibe-ch/covid19-mhsr/tree/master/dhall-instruments)
[Dhall](dhall-lang.org) language offers types and functions in the definition of
REDCap instruments.

### [Repo contents](https://github.com/esm-ispm-unibe-ch/covid19-mhsr/tree/master/dhall-instruments)
* `redcap_dictionary.dhall` defines a REDCap instrument field
  * `makeRedCapMap` function converts fields to json through `dhall-to-json`.
* `dhall-to-instrument.sh`is a bash script to turn dhall instrument to
  uploadable zip file. Needs `json2csv` which can be installed with `nmp install -g json2csv`
