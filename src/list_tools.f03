MODULE list_tools
IMPLICIT NONE

LOGICAL, PARAMETER :: asc = .TRUE., des = .FALSE.

contains

  INTERFACE is_sorted
    MODULE PROCEDURE is_sorted_real
    MODULE PROCEDURE is_sorted_int
  END INTERFACE is_sorted 



  LOGICAL FUNCTION is_sorted_real(lengthfile, x, ordering)
    REAL, INTENT(IN) :: x(:)
    INTEGER, INTENT(IN) :: lengthfile
    INTEGER :: i
    LOGICAL, OPTIONAL :: ordering

    if ( present(ordering) ) then
        do i = 1, lengthfile-1
          if (x(i) > x(i+1)) then
            is_sorted_real = .FALSE.
            exit
          else
            is_sorted_real = .TRUE.
          end if
        end do
    else
        do i = 1, lengthfile-1
          if (x(i) < x(i+1)) then
            is_sorted_real = .FALSE.
            exit
          else
            is_sorted_real = .TRUE.
          end if
        end do
    end if

  END FUNCTION is_sorted_real

END MODULE

LOGICAL FUNCTION is_sorted_int(lengthfile, x, ordering)
  REAL, INTENT(IN) :: x(:)
  INTEGER, INTENT(IN) :: lengthfile
  INTEGER :: i
  LOGICAL, OPTIONAL :: ordering

  if ( present(ordering) ) then
      do i = 1, lengthfile-1
        if (x(i) > x(i+1)) then
          is_sorted_int = .FALSE.
          exit
        else
          is_sorted_int = .TRUE.
        end if
      end do
  else
      do i = 1, lengthfile-1
        if (x(i) < x(i+1)) then
          is_sorted_int = .FALSE.
          exit
        else
          is_sorted_int = .TRUE.
        end if
      end do
  end if

END FUNCTION is_sorted_int

END MODULE
