MODULE sorting
  IMPLICIT NONE
  PRIVATE
  PUBLIC :: simplesort, bubblesort, insertionsort, BoUpMergeSort, BoUpMerge, quicksort
CONTAINS

!---------------------------------------------------------------------------

  ! pathetically bad sorting algorithm:
  ! loop over all unique pairs and swap the values
  ! if the left element is larger than the right one.
  SUBROUTINE simplesort(dat)
    IMPLICIT NONE
    REAL,DIMENSION(:),INTENT(inout) :: dat
    INTEGER :: num, i, j
    REAL :: tmp

    num = SIZE(dat,1)
    IF (num < 2) RETURN
    DO i=1,num-1
        DO j=i+1,num
            IF (dat(i) > dat(j)) THEN
                tmp = dat(i)
                dat(i) = dat(j)
                dat(j) = tmp
            END IF
        END DO
    END DO
  END SUBROUTINE simplesort

!---------------------------------------------------------------------------

  SUBROUTINE bubblesort(dat)
    IMPLICIT NONE
    REAL, DIMENSION(:), INTENT(inout) :: dat
    INTEGER :: num, i, j
    REAL :: temp
    LOGICAL :: swapped

    num = SIZE(dat,1)
    IF (num < 2) RETURN
    DO j = num -1, 1, -1
      swapped = .FALSE.
      DO i = 1, j
        IF (dat(i) > dat(i+1)) THEN
          temp = dat(i)
          dat(i) = dat(i+1)
          dat(i+1) = temp
          swapped = .TRUE.
        END IF
      END DO
      IF (.NOT. swapped) EXIT
    END DO
END SUBROUTINE bubblesort

!---------------------------------------------------------------------------

SUBROUTINE insertionsort(dat)
  IMPLICIT NONE
  REAL, DIMENSION(:), INTENT(inout) :: dat
  REAL :: temp
  INTEGER :: num, i, j

  num = SIZE(dat,1)
  IF (num < 2) RETURN
  DO i = 2, num
     j = i - 1
     temp = dat(i)
     DO WHILE (j>=1 .AND. dat(j)>temp)
        dat(j+1) = dat(j)
        j = j - 1
     END DO
     dat(j+1) = temp
  END DO
END SUBROUTINE insertionsort

!---------------------------------------------------------------------------

SUBROUTINE BoUpMergeSort(dat)
  REAL, DIMENSION(:), INTENT(inout) :: dat
  INTEGER :: left_start, mid, right_end, size_dat, curr_size

  size_dat = SIZE(dat,1)

  curr_size = 1
  DO WHILE (curr_size <= size_dat - 1)
       DO left_start=0, size_dat - curr_size, 2*curr_size
           mid = left_start + curr_size - 1
           right_end = MIN(left_start + 2*curr_size - 1, size_dat - 1)
          CALL  BoUpMerge(dat, left_start, mid, right_end, size_dat)
       END DO
       curr_size = 2*curr_size
   END DO
END SUBROUTINE BoUpMergeSort

SUBROUTINE BoUpMerge(dat,l,m,r,size_dat)

 INTEGER :: l, m, r, size_dat
 REAL, DIMENSION(0 : size_dat - 1), INTENT(in out) :: dat
 INTEGER :: i, j ,k

 REAL :: left(0 : m-l)
 REAL :: right(0 : r - m - 1)

    do i = 0, SIZE(left)-1
        left(i) = dat(l + i)
      end do

    do j=0,SIZE(right)-1
        right(j) = dat(m + 1+ j)
      end do

    i = 0
    j = 0
    k = l
    do while (i < SIZE(left) .AND. j < SIZE(right))
        if (left(i) <= right(j)) then
            dat(k) = left(i)
            i= i+1
        else
            dat(k) = right(j)
            j=j+1
        end if
        k = k+1
  end do

  do while (i < SIZE(left))
        dat(k) = left(i)
        i = i + 1
        k = k + 1
  end do

  do while (j < SIZE(right))
        dat(k) = right(j)
        j=j+1
        k=k+1
  end do
end subroutine BoUpMerge

!---------------------------------------------------------------------------

  ! quicksort implementation via recursion
  ! top-level takes whole array, recursions work on subsets.
  ! pick pivot element and recursively sort the two sublists.
  SUBROUTINE quicksort(dat)
    IMPLICIT NONE
    REAL,DIMENSION(:),INTENT(inout) :: dat
    INTEGER :: num, p

    num = SIZE(dat,1)
    IF (num < 2) RETURN

    p = select_pivot(dat,1,num)
    CALL quicksort_recurse(dat,1,p-1)
    CALL quicksort_recurse(dat,p+1,num)
  END SUBROUTINE quicksort

  RECURSIVE SUBROUTINE quicksort_recurse(dat,left,right)
    IMPLICIT NONE
    REAL,DIMENSION(:),INTENT(inout) :: dat
    INTEGER,INTENT(in) :: left, right
    INTEGER :: p

    IF (left < right) THEN
        p = select_pivot(dat,left,right)
        CALL quicksort_recurse(dat,left,p-1)
        CALL quicksort_recurse(dat,p+1,right)
    END IF
  END SUBROUTINE quicksort_recurse

  ! core step in quicksort. pick pivot value. then swap
  ! array elements so that smaller values are to the left of
  ! it and all larger values to the right. store pivot in
  ! the remaining spot. this element is now in its final location.
  ! return the index of the pivot element.
  ! The choice of the pivot is arbitrary, but crucial for getting
  ! good performance with presorted data.
  RECURSIVE FUNCTION select_pivot(dat,left,right) RESULT(i)
    IMPLICIT NONE
    REAL,DIMENSION(:),INTENT(inout) :: dat
    INTEGER :: i, j, right, left
    REAL :: tmp, pivot

    ! this is the classic choice of pivot element, assuming random data
    pivot = dat(right)
    ! an element in the middle is a much better choice for presorted data
    pivot = dat((left+right)/2)
    i = left
    DO j=left,right-1
        IF (pivot > dat(j)) THEN
            tmp = dat(i)
            dat(i) = dat(j)
            dat(j) = tmp
            i = i+1
        END IF
    END DO
    dat(right) = dat(i)
    dat(i) = pivot
  END FUNCTION select_pivot

END MODULE sorting
