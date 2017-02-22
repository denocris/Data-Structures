PROGRAM readint
IMPLICIT NONE

  TYPE pair
    INTEGER :: key
    REAL :: val
  END TYPE pair


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

  PRINT*, 'The length of the array is', lengthfile
  IF ( ABS(mysum - correctsum)/ ABS(mysum) < 1.0e-5 ) THEN
    PRINT*, 'The sum is Correct!', mysum
  ELSE
    PRINT*, 'Wrong, my sum is', mysum , &
    'which is different from', correctsum
  END IF

  DEALLOCATE(list)

END PROGRAM readint
