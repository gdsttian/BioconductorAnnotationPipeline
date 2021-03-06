## Makes OrgDbs, TxDbs
## NOTE: Install new db0 packages before running this script.



## -----------------------------------------------------------------------
## Make OrgDb:
## -----------------------------------------------------------------------
library(AnnotationForge)
library(AnnotationDbi)

## 1. run copyLatest.sh to move KEGG, GO, PFAM, and YEAST to sanctionedSqlite

## 2. Create *.sqlite files in 'sanctionedSqlite'
outDir <- "sanctionedSqlite"
if (!file.exists(outDir)) 
    dir.create(outDir)
dbBaseDir <- "/home/ubuntu/BioconductorAnnotationPipeline/annosrc/db/"
metaDataSrc <- paste0(dbBaseDir, "metadatasrc.sqlite")
source("EGPkgs.R")

## 3. Edit version numbers (and path if necessary) in
## AnnotationForge/inst/scripts/GentlemanLab/ANNDBPKG-INDEX.TXT
## The .TXT file has the version and location to the *.sqlite files hard coded
## and must be edited by hand before generating the final packages.
## Currently the path points to sanctionedSqlite/ so the intermediate sqlite
## files must be created there (done in step 2).

## Create packages in 'orgdbDir' from the *.sqlite files in 'sanctionedSqlite'
dateDir = "./20171108"
orgdbDir <- paste(dateDir,"_OrgDbs",sep="")
if (!file.exists(orgdbDir)) 
    dir.create(orgdbDir)
sqlitefiles <- list.files(outDir, pattern="^org")
packages <- paste(substr(sqlitefiles, 1, nchar(sqlitefiles)-7), ".db", sep="")
## include GO.db, PFAM.db
packages <- c(packages, "GO.db", "PFAM.db")
makeAnnDbPkg(x=packages, dest_dir=orgdbDir)

## -----------------------------------------------------------------------
## Make TxDb:
## -----------------------------------------------------------------------
library(GenomicFeatures)
dateDir = "./20171002"
txdbDir <- paste(dateDir,"_TxDbs",sep="")
if (!file.exists(txdbDir)) 
    dir.create(txdbDir)
version <- "3.4.2"
source(system.file("script","makeTxDbs.R", package="GenomicFeatures"))
TxDbPackagesForRelease(version=version, 
                       destDir=txdbDir,
                       maintainer= paste0("Bioconductor Package Maintainer ",
                                          "<maintainer@bioconductor.org>"),
                       author="Bioconductor Core Team")

## -----------------------------------------------------------------------
## Make ChipDb packages:
## -----------------------------------------------------------------------
## ChipDb are no longer built as of Bioconductor 3.3
#affyBaseDir <- "/home/ubuntu/cpb_anno/AnnotationBuildPipeline/srcFiles/"
#source("humanPkgs.R")
#source("mousePkgs.R")
#source("ratPkgs.R") 
#source("flyPkgs.R")
#source("arabidopsisPkgs.R")
#source("yeastPkgs.R")  
#source("eclecticChipPkgs.R")

## -----------------------------------------------------------------------
## Marc's notes:
## this last script is out of repair (but we need a new solution for tRNAs anyways)
## source(system.file("script","maketRNAFDb.R", package="GenomicFeatures"))
## TODO: I need to edit the following script so that it makes it in the
## TxDbOutDir...
## I think this has been superceded by something better (AnnotationHub)
## source(system.file("script","maketRNAFDb.R", package="GenomicFeatures"))
