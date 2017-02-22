MODULE list_tools
IMPLICIT NONE

INTERFACE is_sorted
  MODULE PROCEDURE is_sorted_real, is_sorted_int
END INTERFACE is_sorted

LOGICAL, PARAMETER :: asc = .TRUE., des = .FALSE.

CONTAINS


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


  LOGICAL FUNCTION is_sorted_int(lengthfile, x, ordering)
    INTEGER, INTENT(IN) :: x(:)
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
