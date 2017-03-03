
I apologize for the sort report. It contains just the necessary data and results.

#####Sorting algorithms

All the sorting algorithms were run on Ulysses cluster. Everything has been tested on three different cases: unsorted, sorted and mostly sorted data. The sizes of the array were: 2000, 5000, 10000, 20000, 50000, 100000, 200000.

Here some benchmarks of the different sorting algorithms implemented. The analisys have been made on three different cases (unsorted, sorted and mostly sorted) for the following arrays sizes: 500,1000,2000,5000,10000,50000,100000,200000.


![Figure_1](already_sorted.png)
In fig.1 the simple sorting is not reported since too slow compared with respect to the others.

![Figure_2](almost_sorted.png)
In fig.2 the bubble sorting is not reported since too slow compared with respect to the others.

![Figure_3](not_sorted.png)

I was expecting the growth of time a little bit different (sometimes it seems linear). I think that probably the sizes chosen for the arrays were not appropriate for a proper time measure. 

####Perf analisys

`perf` analysis on the Ulysses cluster for each sorting algorithm


-------| Simple | Bubble | Insertion | Quick |  Merge | Hybrid
-------|--------|--------|-----------|-------------|-------------|--------|
cache-ref |216.915.843 | 232.200.271 | 43.890.327  | 132.746  | 320.026 |
cache-miss |280.695 |  465.161 | 51.589 |10.515 | 16560 | 15.981 |
instructions| 1.458.593.235.858| 1.492.033.489.477 | 384.957.224.870 | 765.441.350 | 2.201.084.237 | 1.206.282.179 |
cycles |775.465.448.666| 865.297.915.514 | 185.583.127.312 | 424.181.763 | 957.791.410 | 580.446.242 |
branches |159.305.160.013| 158.097.243.838 | 39.852.451.015 | 73.204.982 | 270.160.686 | 114.767.427 |


####Conclusions

The general behaviour is that the slowest cases are the simple, bubble and insertion sorting approaches (in theory $O(N^2)$). However, the latter has higer performances with respect to the formers.

#####Data Structure

-------| array | linked list | hash table | binary tree |  reb binary tree |
-------|--------|--------|-----------|-------------|-------------|--------|
data 1 |1.682000 ms | 3.428000 ms | 0.170000 ms  | 8.868000 ms  |  0.370000 ms |
data 2 |0.372000 ms| 0.761000 ms | 0.072000 ms  | 1.855000 ms |  0.302000 ms |
data 3 |0.924000 ms| 1.844000 ms | 0.123000 ms  | 3.837001 ms |  0.318000 ms |
data 4 |1.697000 ms| 4.267000 ms | 0.160000 ms  | 8.723001 ms |  0.506001 ms |
data 5 |0.650000 ms| 1.370000 ms | 0.146000 ms  | 0.323000 ms |  0.347000 ms |
data 6 |1.682000 ms| 1.367000 ms | 0.132000 ms | 0.414000 ms |  0.394000 ms |


As expected the rebalanced binary tree is the fastest. However very good performances can be achieved if the number of buckets of the hast table is more or less equal to nlook.
