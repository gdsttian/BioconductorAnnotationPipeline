#!/bin/sh
set -e
#HVM is human vs mouse etc.
export IPHVMSOURCEDATE=29-Apr-2008
export IPSOURCENAME="Inparanoid Orthologs"
export IPSOURCEURL="http://inparanoid.sbc.su.se/download/current/sqltables/"

# #FOR NOW, we want to place the ensembl and flybase sources here where they are used,
# #BUT these might be moved someday, so I will try to keep things insulated
# export ENSOURCEDATE=
# export ENSOURCENAME="Ensembl"
# export ENSOURCEURL="ftp://ftp.ensembl.org/pub/current_fasta"

export FBSOURCEDATE=2017-Feb01
export FBSOURCENAME="Flybase"
export FBSOURCEURL="ftp://ftp.flybase.net/releases/current/precomputed_files/genes/"
## Check and rename each time 
FILE="fbgn_fbtr_fbpp_fb_2017_01.tsv.gz"
UZFILE="fbgn_fbtr_fbpp_fb_2017_01.tsv"
