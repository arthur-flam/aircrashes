Aviation data
=============


## Get the data ##

Download the full database from [ntsb.gov](http://www.ntsb.gov/aviationquery).
Clean it with
```shell
sed "s/ \| /|/g" AviationData.txt > AviationData.clean.txt
```
## Run the app ##
 ```r
require(shiny)
runApp()
```

## Todo ##
- add maps
- clean the data (helicopters, gliders...)
- add more info in the tooltips
- add data from other countries using maybe [airdisaster.com](http://www.airdisaster.com/), [planecrashinfo.com](http://www.planecrashinfo.com/) or [aviation-safety.net](http://aviation-safety.net/).
