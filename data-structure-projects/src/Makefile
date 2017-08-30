FC = gfortran
FFLAGS = -Wall -O3
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
	#./09_simplesort.x
	perf stat -B -e cache-references,cache-misses,cycles,instructions,branches,faults,migrations ./09_simplesort.x

10: 10_bubblesort.x
	#./10_bubblesort.x
	perf stat -B -e cache-references,cache-misses,cycles,instructions,branches,faults,migrations ./10_bubblesort.x

11: 11_insertionsort.x
	#./11_insertionsort.x
	perf stat -B -e cache-references,cache-misses,cycles,instructions,branches,faults,migrations ./11_insertionsort.x

12: 12_quicksort.x
	#./12_quicksort.x
	perf stat -B -e cache-references,cache-misses,cycles,instructions,branches,faults,migrations ./12_quicksort.x

13: 13_mergesort.x
	#./13_mergesort.x
	perf stat -B -e cache-references,cache-misses,cycles,instructions,branches,faults,migrations ./13_mergesort.x

14: 14_hybridsort.x
	#./14_hybridsort.x
	perf stat -B -e cache-references,cache-misses,cycles,instructions,branches,faults,migrations ./14_hybridsort.x

17: 17_linked_list.x
	for i in `seq 1 6 `; do ./17_linked_list.x < ../data/d3\_$$i.dat; done
	#for i in `seq 1 6 `; do valgrind ./17_linked_list.x < ../data/d3\_$$i.dat; done

18: 18_hash_table.x
	for i in `seq 1 6 `; do ./18_hash_table.x < ../data/d3\_$$i.dat; done
	#for i in `seq 1 6 `; do valgrind ./18_hash_table.x < ../data/d3\_$$i.dat; done

19: 19_stack_array.x
	./19_stack_array.x
	#valgrind ./19_stack_array.x

20: 20_stack_list.x
	./20_stack_list.x
	#valgrind ./20_stack_list.x

21: 21_binary_tree.x
	for i in `seq 1 6 `; do ./21_binary_tree.x < ../data/d3\_$$i.dat; done
	#for i in `seq 1 6 `; do valgrind ./21_binary_tree.x < ../data/d3\_$$i.dat; done

22: 22_binary_tree.x
	for i in `seq 1 6 `; do ./22_binary_tree.x< ../data/d3\_$$i.dat; done
	#for i in `seq 1 6 `; do valgrind ./22_binary_tree.x< ../data/d3\_$$i.dat; done

23: 23_reb_binary_tree.x
	for i in `seq 1 6 `; do ./23_reb_binary_tree.x < ../data/d3\_$$i.dat; done
	#for i in `seq 1 6 `; do valgrind ./23_reb_binary_tree.x < ../data/d3\_$$i.dat; done

class: class.x
		./class.x

list_tools.o: list_tools.f03 list_types.o

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

17_linked_list.x: list_types.o list_tools.o sorting.o 17_linked_list.o
	$(FC) $^ -o $@

18_hash_table.x: list_types.o list_tools.o sorting.o 18_hash_table.o
	$(FC) $^ -o $@

19_stack_array.x: list_types.o 19_stack_array.o
	$(FC) $^ -o $@

20_stack_list.x: list_types.o 20_stack_list.o
	$(FC) $^ -o $@

21_binary_tree.x: list_types.o bintree_tools.o 21_binary_tree.o
		$(FC) $^ -o $@

22_binary_tree.x: list_types.o bintree_tools.o 22_binary_tree.o
		$(FC) $^ -o $@

23_reb_binary_tree.x: list_types.o bintree_tools.o 23_reb_binary_tree.o
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
