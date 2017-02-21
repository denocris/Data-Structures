FC = gfortran
FFLAGS = -Wall
#TARGET = a.out

# delete default suffixes conventions
.SUFFIXES:

all: 01 02 03

01: 01_readint.x
	for i in `seq 1 6 `; do ./01_readint.x < ../data/d1\_$$i.dat; done

02: 02_readreal.x
	for j in `seq 1 2`;do for i in `seq 1 6 `; do ./02_readreal.x < ../data/d$$j\_$$i.dat; done ;done

03: 03_sorted.x
	for i in `seq 1 6 `; do ./03_sorted.x < ../data/d1\_$$i.dat; done

04: 04_rsorted.x
	for j in `seq 1 2`;do for i in `seq 1 6 `; do ./04_rsorted.x < ../data/d$$j\_$$i.dat; done ;done

01_readint.x: 01_readint.o
	$(FC) $^ -o $@

02_readreal.x: 02_readreal.o
	$(FC) $^ -o $@

03_sorted.x: 03_sorted.o
	$(FC) $^ -o $@

04_rsorted.x: list_tools.o 04_rsorted.o
	$(FC) $^ -o $@


%.o: %.f03
	$(FC) -c $< $(FFLAGS) -o $@


clean:
	rm -f *.o *~ *.x *.out

.PHONY: clean
