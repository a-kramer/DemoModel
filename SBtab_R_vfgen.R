#!/usr/bin/Rscript
library('SBtabVFGEN')
files=commandArgs(trailingOnly = TRUE);
if (all(file.exists(files))){
    message(sprintf("parsing file: «%s»",files));
    SBtab <- sbtab_from_tsv(files)
    message(sprintf("converting %i sheets to a VFGEN model.",length(SBtab[['Table']])));
    Model <- sbtab_to_vfgen(SBtab)
}
