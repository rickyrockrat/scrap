#!/bin/bash -e
# get_coverart.sh
#
# This simple script will fetch the cover art for the album information provided on the command line.
# It will then download that cover image, and place it into the child directory.
#
# ./get_coverart.sh 
#
# get_coverart Beatles/Sgt Pepper
#
# get_coverart Beatles/Sgt_Pepper
#
# get_coverart "Beatles - Sgt_Pepper"
#
# To auto-populate all directories in the current directory, run the following command
#
# find . -type d -exec ./get_coverart "{}" ;
albumpath="$1"

# Escape any problematic character
encoded="$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$albumpath")"

# Skip if a cover.jpg exists in the directory
if [ -f "$albumpath/cover.jpg" ]
then
echo "$albumpath/cover.jpg already exists"
exit
fi

# Tell the user what is going on
echo ""
echo "Searching for: [$1]"

# scraping AlbumArt.org
url="http://www.albumart.org/index.php?skey=$encoded&itempage=1&newsearch=1&searchindex=Music"
echo "Searching ... [$url]"

# Grab the first Amazon image without an underscore (usually the largest version)
coverurl=`wget -qO - "$url" | grep -m 1 -o 'http://ecx.images-amazon.com/images/I/*/[%0-9a-zA-Z.,-]*.jpg'`

echo "Cover URL: [$coverurl]"

# Save the imager
wget "$coverurl" -O "$albumpath/cover.jpg"
