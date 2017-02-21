

PROGRAM readint
USE list_tools
IMPLICIT NONE
  INTEGER, DIMENSION(:), ALLOCATABLE :: x
  INTEGER :: lengthfile
  INTEGER :: correctsum
  INTEGER :: mysum = 0
  INTEGER :: i

  READ(5,*) lengthfile ! read first line
  ALLOCATE(x(lengthfile))
  READ(5,*) (x(i), i=1,lengthfile)
  READ(5,*) correctsum

  mysum = SUM(x)
  !mysum = SUM(x) + 1 ! to test if statement

  PRINT*, 'The length of the array is', lengthfile
  if ( mysum == correctsum ) then
    PRINT*, 'The sum is Correct!', mysum
  else
    PRINT*, 'Wrong, my sum is', mysum , &
    'which is different from', correctsum
  end if
  PRINT*, 'Sorted?', issorted(lengthfile, x)

END PROGRAM readint
