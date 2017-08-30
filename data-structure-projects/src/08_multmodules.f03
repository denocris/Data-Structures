
PROGRAM readint
USE list_tools
IMPLICIT NONE
  TYPE(pair), DIMENSION(:), ALLOCATABLE :: list
  INTEGER :: lengthfile
  REAL :: correctsum
  REAL :: mysum = 0
  INTEGER :: i

  READ(5,*) lengthfile ! read first line
  ALLOCATE(list(lengthfile))
  READ(5,*) (list(i), i=1,lengthfile)
  READ(5,*) correctsum

  mysum = SUM(list%val)
  !mysum = SUM(x) + 1 ! to test if statement


  PRINT*, 'The length of the array is', lengthfile
  if ( ABS(mysum - correctsum)/ ABS(mysum) < 1.0e-5 ) then
    PRINT*, 'The sum is Correct!', mysum
  else
    PRINT*, 'Wrong, my sum is', mysum , &
    'which is different from', correctsum
  end if
  PRINT*, 'Check if sorted by value in ascending order (default)', is_sorted(lengthfile, list)
  PRINT*, 'Check if sorted by value in ascending order', is_sorted(lengthfile, list, asc, byvalue)
  PRINT*, 'Check if sorted by key in descending order', is_sorted(lengthfile, list, des, bykey)

  DEALLOCATE(list)

END PROGRAM readint
