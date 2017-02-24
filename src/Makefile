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

05: 05_rsorted.x
	for j in `seq 1 2`;do for i in `seq 1 6 `; do ./05_rsorted.x < ../data/d$$j\_$$i.dat; done ;done

07: 07_dertypes.x
	for i in `seq 1 6 `; do ./07_dertypes.x < ../data/d3\_$$i.dat; done

08: 08_multmodules.x
	for i in `seq 1 6 `; do ./08_multmodules.x < ../data/d3\_$$i.dat; done

09: 09_simplesort.x
	./09_simplesort.x

10: 10_bubblesort.x
	./10_bubblesort.x

11: 11_insertionsort.x
	./11_insertionsort.x

12: 12_quicksort.x
	./12_quicksort.x

13: 13_mergesort.x
	./13_mergesort.x

14: 14_hybridsort.x
	./14_hybridsort.x

17: 17_array_lookup.x
	for i in `seq 1 6 `; do ./17_array_lookup.x < ../data/d3\_$$i.dat; done

class: class.x
		./class.x

01_readint.x: 01_readint.o
	$(FC) $^ -o $@

02_readreal.x: 02_readreal.o
	$(FC) $^ -o $@

03_sorted.x: list_tools.o 03_sorted.o
	$(FC) $^ -o $@

04_rsorted.x: list_tools.o 04_rsorted.o
	$(FC) $^ -o $@

05_rsorted.x: list_tools.o 05_rsorted.o
	$(FC) $^ -o $@

07_dertypes.x: list_tools.o 07_dertypes.o
	$(FC) $^ -o $@

08_multmodules.x: list_types.o list_tools.o 08_multmodules.o
	$(FC) $^ -o $@

09_simplesort.x: list_types.o list_tools.o sorting.o 09_simplesort.o
	$(FC) $^ -o $@

10_bubblesort.x: list_types.o list_tools.o sorting.o 10_bubblesort.o
	$(FC) $^ -o $@

11_insertionsort.x: list_types.o list_tools.o sorting.o 11_insertionsort.o
	$(FC) $^ -o $@

12_quicksort.x: list_types.o list_tools.o sorting.o 12_quicksort.o
	$(FC) $^ -o $@

13_mergesort.x: list_types.o list_tools.o sorting.o 13_mergesort.o
	$(FC) $^ -o $@

14_hybridsort.x: list_types.o list_tools.o sorting.o 14_hybridsort.o
	$(FC) $^ -o $@

17_array_lookup.x: list_types.o list_tools.o sorting.o 17_array_lookup.o
		$(FC) $^ -o $@

class.x: list_types.o list_tools.o sorting.o class.o
		$(FC) $^ -o $@


%.o: %.f03
	$(FC) -c $< $(FFLAGS) -o $@  # metti @ all'inizio per togliere warning

%.o: %.f90
	$(FC) -c $< $(FFLAGS) -o $@


clean:
	rm -f *.o *~ *.x *.out

.PHONY: clean
