MODULE list_tools
IMPLICIT NONE

contains

  LOGICAL FUNCTION issorted(lengthfile,x)
    !IMPLICIT NONE
    INTEGER, INTENT(IN) :: x(:)
    INTEGER, INTENT(IN) :: lengthfile
    INTEGER :: prec, next, i
    do i = 1, lengthfile-1
      if (x(i) > x(i+1)) then
        issorted = .FALSE.
        exit
      else
        issorted = .TRUE.
      end if
    end do
  END FUNCTION issorted

END MODULE
