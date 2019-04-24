.PHONY: all clean

export PATH := $(HOME)/Documents/SBtabVFGEN/:$(HOME)/mcmc_clib/bin:$(PATH)

CC=gcc

MODEL = Demo

ODS_TO_TSV = ods_to_tsv.sh
TSV_TO_ODS = tsv_to_ods.sh
TSV_TO_H5 = sbtab_import
VFGEN = ~/mcmc_clib/vfgen

all: ./C/$(MODEL).so ./vfgen/$(MODEL)_vf.xml ./data/$(MODEL).h5 ./matlab/$(MODEL)_vf.m ./SBtab/tsv/$(MODEL)_Experiments.tsv ./C/$(MODEL)_cvs.c

clean:
	rm ./C/$(MODEL).so ./data/$(MODEL).h5 ./matlab/$(MODEL)_*.m ./SBtab/tsv/$(MODEL)_*.tsv ./C/$(MODEL)_cvs.[ch] ./vfgen/$(MODEL)_vf.xml

./C/$(MODEL)_cvs.c: ./vfgen/$(MODEL)_vf.xml C
	cd ./C && $(VFGEN) cvodes:func=yes,sens=yes ../vfgen/$(MODEL)_vf.xml

./C/$(MODEL).so: ./C/$(MODEL)_cvs.c C
	$(CC) -shared -fPIC -O2 $< -o $@

./vfgen/$(MODEL)_vf.xml: ./SBtab/$(MODEL).ods vfgen
	 cd ./vfgen && ../SBtab_R_vfgen.R ../SBtab/$(MODEL).ods

./data/$(MODEL).h5: ./SBtab/tsv/$(MODEL)_Experiments.tsv data
	cd ./data/ && $(TSV_TO_H5) ../SBtab/tsv/*.tsv $(MODEL).h5 > ../sbtab_to_hdf5.log

./matlab/$(MODEL)_vf.m: ./vfgen/$(MODEL)_vf.xml matlab
	cd ./matlab/ && $(VFGEN) matlab:func=yes ../vfgen/$(MODEL)_vf.xml

./SBtab/tsv/$(MODEL)_Experiments.tsv: ./SBtab/$(MODEL).ods ./SBtab/tsv
	cd ./SBtab/tsv && $(ODS_TO_TSV) ../$(MODEL).ods

data C matlab vfgen:
	mkdir $@

./SBtab/tsv:
	mkdir ./SBtab/tsv
