
PROGRAM readint
USE list_tools
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
  if ( ABS(mysum - correctsum)/ ABS(mysum) < 1.0e-5 ) then
    PRINT*, 'The sum is Correct!', mysum
  else
    PRINT*, 'Wrong, my sum is', mysum , &
    'which is different from', correctsum
  end if
  PRINT*, 'Check if sorted by ascending order (default)', issorted_real(lengthfile, x)
  PRINT*, 'Check if sorted by ascending order', issorted_real(lengthfile, x, des)
  PRINT*, 'Check if sorted by descending order', issorted_real(lengthfile, x, des)

END PROGRAM readint
