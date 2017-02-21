PROGRAM readint
IMPLICIT NONE
  REAL, DIMENSION(:), ALLOCATABLE :: x
  INTEGER :: lengthfile
  REAL :: correctsum
  REAL :: mysum = 0
  INTEGER :: i

  READ(5,*) lengthfile ! read first line
  ALLOCATE(x(lengthfile))
  READ(5,*) (x(i), i=1,lengthfile)
  READ(5,*) correctsum

  mysum = SUM(x)
  !mysum = SUM(x) + 1 ! to test if statement

  PRINT*, 'The length of the array is', lengthfile
  IF ( ABS(mysum - correctsum)/ ABS(mysum) < 1.0e-5 ) THEN
    PRINT*, 'The sum is Correct!', mysum
  ELSE
    PRINT*, 'Wrong, my sum is', mysum , &
    'which is different from', correctsum
  END IF

END PROGRAM readint
