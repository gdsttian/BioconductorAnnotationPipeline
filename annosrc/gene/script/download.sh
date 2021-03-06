#!/bin/sh
set -e
. ./env.sh

BASE_URL=$EGSOURCEURL
PARENT_URL=$EGSOURCEURL/..
THIS_YEAR=`date|awk '{print $6}'`
LATEST_DATE=`curl -s --disable-epsv -L $PARENT_URL/|grep "DATA"|awk '{print $8 "-" $6 $7}'|sed -e "s/^[0-9]*:[0-9]*-/$THIS_YEAR-/g"`

if [ -z "$LATEST_DATE" ]; then
       echo "download.sh: latest date from $BASEURL not found"
       exit 1
fi

if [ "$LATEST_DATE" != "$EGSOURCEDATE" ]; then
	echo "update crossreferences from $EGSOURCENAME to other databases from $EGSOURCEDATE to $LATEST_DATE"
        sed -i -e "s/ EGSOURCEDATE=.*$/ EGSOURCEDATE=$LATEST_DATE/g" env.sh
	mkdir ../$LATEST_DATE
	cd ../$LATEST_DATE
	curl --disable-epsv -O $BASE_URL/gene2go.gz
	curl --disable-epsv -O $BASE_URL/gene2pubmed.gz
	curl --disable-epsv -O $BASE_URL/gene2refseq.gz
	curl --disable-epsv -O $BASE_URL/gene2accession.gz
	curl --disable-epsv -O $BASE_URL/gene2unigene
	curl --disable-epsv -O $BASE_URL/mim2gene_medgen
	curl --disable-epsv -O $BASE_URL/gene_info.gz
	curl --disable-epsv -O $BASE_URL/gene_refseq_uniprotkb_collab.gz
	cd ../script
	#sh getsrc.sh
else
	echo "the latest crossreferences from $EGSOURCENAME to other databases are still $EGSOURCEDATE"
fi
