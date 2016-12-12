# Keep
##collectDownload  -  Feb 4 2016
Part of thumb drive work
Pull things from web download of the cart receipt page. 

##convertClipboard  -  Apr 9 2016
single line invocation to run the clipboard through convertRunningList and put the results back on the clipboard

##convertRunningList  -  Jun 26 17:48
Given 2 tsv columns of dog name and human name, convert to the dogHandler format

##dropbox-services  -  May 17 2015
Run the dropbox spring-boot webapp

##dupe  -  Nov 19 09:47
a routine to make a duplicate of a folder using hard links
handy for making a backup before some other destructive operation.

dupe foo yields foo.copy

see also flatdupe

##flatdupe  -  Nov 19 09:47
a routine to make a duplicate of a folder using hard links, but all flattened into one dir handy for making a backup before some other destructive operation. duplicate files in different directories are will get the later instance

flatdupe foo yieds foo.flatcopy

See dupe

##gdpFixImageNames  -  Nov 21 20:22
The workhorse of old renames


##gdpJalbumImport  -  Jul 21 2006
Pull images from /GDP/jalbum to /Web/proofImages

Often still referenced in conversati


##gdpLowerImages  -  Mar 31 2007
recursively lowercase of type jpg|tif|cr2|crw

##mergeFolders  -  Oct 19 2005
copy two folders together, creating dirs as needed. 

##onsiteDownload  -  Feb 10 2016
loop on media mount, download cart, eject

##onsiteSort  -  Jun 26 17:50
consolidated prompt script, does not loop. Interactive choice between fancySort and runningOrderSort

##printCart  -  Nov 25 12:08
Pull a cart receipt from the app, create PDF, and print it

##runningOrderSort  -  Jun 26 17:50
looks current

##trimFolder  -  Jul 23 2009
a routine to take a source dir full of desired images, a destination dir 
full of all original images, and delete any of the originals.


----

# retain, but old
##fancySort  -  Sep 6 2006
an interactive script for sorting images. does the rollover work. Was useful when running lists were scarce, and the data entry of numbers and 
names happened at the same time

##onsiteSort.fancySort  -  May 3 2006
looping prompt for repeated invocations of fancySort. Tries to call the web server


## keep cartConfirm  -  May 20 2013
 A safety net during the consolidate process. After the manual consolidate 
 actions are done with a directory full of images, this is run to confirm 
 that every order consolidated all the proper images.

 Run this from the directory containing the raw images: 
  cartConfirm destinationDirectory

----

# Deprecated

##gdpConsolidate  -  Jul 7 2009
prompt to flip discs of things needing consolidate

##gdpImportCds  -  Aug 2 2006
master script for indexing CD backups

##gdpImportImages  -  Apr 28 2004
old. Moving files into proofImages. Seems like gdpJalbumImport is based on this

##gdpListCdImages  -  Sep 21 2005
List files on a CD for backup index

##gdpProofPull  -  Aug 15 2010
take list of images and filename prefixes on stdin
and prompt for which of the disks it can be found on

##gdpSimpleConsolidate  -  Jun 24 2015
take list of images and filename prefixes on stdin
and prompt for which of the disks it can be found on


##onsiteSortLower  -  Mar 31 2007
old. almost same as onsiteSort.fancySort, but with handling lower case extensions

----

# Obsolete

##gdpDistinctImages  -  Nov 13 2005
given the current directory full of regularly consolidated images,
this will reduce the folder to the distinct images available.
Amy will take that list, and make the unique list of PSDs
As a hack, this list can then be used as a consolidate directory
from the app, do another consolidate, and then the only thing left is to
select the cropping and other stuff.



##cdCreate  -  Aug 17 2003
creates an html file of cd. Uses database


##csv2tsv  -  Oct 18 2003
obvious by name. Uses perl lib


##gdpFindImages  -  Nov 28 2005
take list of images and filename prefixes on stdin
and prompt for which of the disks it can be found on

##gdpFindImagesDb  -  Dec 12 2005
take list of images and filename prefixes from the db table
and prompt for which of the disks it can be found on

##gdpFindImagesPlain  -  Dec 26 2005
backup file of gdpFindImages? 

##gdpOnlineList  -  May 1 2004
this file generates a "list.txt" file in */slides
for use by Photo Preview
the file contains just the filename, no extention

##importRaw  -  Oct 16 2006
find raw images on a card, copy them and eject the card

##toAppleworks  -  Oct 23 2003
add LF to make CRLF


##testGdp  -  Oct 16 2003
##testMe  -  May 3 2006

# confirmed kill

* _GDCA related_
* gdcaCatalog  -  Oct 25 2003
create html file of gdca data. Lots of perl lib usage
* gdcaFolderLabels  -  Oct 22 2003
create sql insert statements for folder names by splitting stdin
* gdcaImport  -  Oct 21 2004
combined script for gdca imports in 2004

* gdcaProofData  -  Apr 26 2004
generate index files of gdca folders
* gdcaWins  -  Feb 23 2004
generate static files listing winners of gdca

* photo previews
* ppData  -  Oct 12 2006
* ppData.label  -  Oct 13 2006
* ppDirList  -  Oct 13 2006
* ppGenerate  -  Apr 14 2006
* ppMaster  -  Apr 14 2006
* ppOnlineList  -  May 18 2004
* ppPostProofs  -  Jul 25 2006
* ppUndoOnline  -  Jul 25 2006

* old static site creator
* siteCreate  -  Apr 14 2006
* testExpando  -  Oct 16 2003
