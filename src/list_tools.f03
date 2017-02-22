MODULE list_tools
USE list_types
IMPLICIT NONE

INTERFACE is_sorted
  MODULE PROCEDURE is_sorted_real, is_sorted_int, is_sorted_pair
END INTERFACE is_sorted

LOGICAL, PARAMETER :: asc = .TRUE., des = .FALSE.
LOGICAL, PARAMETER :: byvalue = .TRUE., bykey = .FALSE.

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

  LOGICAL FUNCTION is_sorted_pair(lengthfile, list, ordering, which_one)
    TYPE(pair), INTENT(IN) :: list(:)
    INTEGER, INTENT(IN) :: lengthfile
    INTEGER :: i
    LOGICAL, OPTIONAL :: ordering
    LOGICAL, OPTIONAL :: which_one

    if ( present(which_one) ) then
      if ( present(ordering) ) then
          do i = 1, lengthfile-1
            if (list(i)%val > list(i+1)%val) then
              is_sorted_pair = .FALSE.
              exit
            else
              is_sorted_pair = .TRUE.
            end if
          end do
      else
          do i = 1, lengthfile-1
            if (list(i)%val < list(i+1)%val) then
              is_sorted_pair = .FALSE.
              exit
            else
              is_sorted_pair = .TRUE.
            end if
          end do
      end if
    else
      if ( present(ordering) ) then
          do i = 1, lengthfile-1
            if (list(i)%key > list(i+1)%key) then
              is_sorted_pair = .FALSE.
              exit
            else
              is_sorted_pair = .TRUE.
            end if
          end do
      else
          do i = 1, lengthfile-1
            if (list(i)%key < list(i+1)%key) then
              is_sorted_pair = .FALSE.
              exit
            else
              is_sorted_pair = .TRUE.
            end if
          end do
      end if
    end if

  END FUNCTION is_sorted_pair

END MODULE
