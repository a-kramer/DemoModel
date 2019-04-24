#!/usr/bin/Rscript

ODS=commandArgs(trailingOnly = TRUE);
message(sprintf("parsing ods file: «%s»",ODS));
source("~/Documents/SBtabVFGEN/sbtab_to_vfgen.R")
SBtab <- readODS::read.ods(ODS)
message(sprintf("converting %i sheets to a VFGEN model.",length(SBtab)));
Model <- sbtab_to_vfgen(SBtab)

# module for twiddling the frobs
