.PHONY: all clean

export PATH := $(HOME)/Documents/SBtabVFGEN/:$(HOME)/mcmc_clib/bin:$(PATH)

CC=gcc

MODEL = Demo

ODS_TO_TSV = sh/ods_to_tsv.sh
TSV_TO_ODS = sh/tsv_to_ods.sh
TSV_TO_H5 = sbtab_import
VFGEN = ~/mcmc_clib/vfgen

all: ./C/$(MODEL).so ./vfgen/$(MODEL).vf ./data/$(MODEL).h5 ./matlab/$(MODEL)_vf.m ./C/$(MODEL)_cvs.c

clean:
	rm ./C/$(MODEL).so ./data/$(MODEL).h5 ./matlab/$(MODEL)_*.m ./SBtab/tsv/$(MODEL)_*.tsv ./C/$(MODEL)_cvs.[ch] ./vfgen/$(MODEL).vf

./C/$(MODEL)_cvs.c: ./vfgen/$(MODEL).vf
	cd ./C && $(VFGEN) cvodes:func=yes,sens=yes ../vfgen/$(MODEL).vf

./C/$(MODEL).so: ./C/$(MODEL)_cvs.c
	$(CC) -shared -fPIC -O2 $< -o $@

./vfgen/$(MODEL).vf: ./SBtab/tsv/*.tsv
	 cd ./vfgen && ../SBtab_R_vfgen.R ../SBtab/tsv/*.tsv && mv $(MODEL).xml ../sbml/

./data/$(MODEL).h5: ./SBtab/tsv/$(MODEL)_Experiments.tsv
	cd ./data/ && $(TSV_TO_H5) ../SBtab/tsv/*.tsv $(MODEL).h5 > ../sbtab_to_hdf5.log

./matlab/$(MODEL)_vf.m: ./vfgen/$(MODEL).vf
	cd ./matlab/ && $(VFGEN) matlab:func=yes ../vfgen/$(MODEL).vf
