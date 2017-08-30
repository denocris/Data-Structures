program NextPrimeProg
IMPLICIT NONE

integer :: num = 5


write(*,*) 'The integer number chosen is', num
CALL nextprime(num)
write(*,*) 'its next prime number', num

num = 9

write(*,*) 'The integer number chosen is', num
CALL nextprime(num)
write(*,*) 'its next prime number', num


CONTAINS

  subroutine nextprime(n)
    INTEGER, INTENT(inout) :: n
    INTEGER :: tmp_n
    LOGICAL :: find = .false.
    INTEGER :: i

    if ( n == 0 ) then
      n = 1
      find = .true.
    else if ( n == 1 ) then
      n = 2
      find = .true.
    else if ( n == 2 ) then
      n = 3
      find = .true.
    else if ( n == 3 ) then
      n = 5
      find = .true.
    end if

  tmp_n = n

  do while ( .NOT. find )

    i = 2
    do while ( i < tmp_n/2 )
        if (mod(tmp_n,i) == 0) then
          exit
        end if
      i=i+1
    end do

    if ( i == tmp_n/2 .AND. n /= tmp_n ) then
      find = .true.
      exit
    end if

    if (find) then
      exit
    else
      tmp_n = tmp_n + 1
      !i = 2
    end if
  end do

  n = tmp_n

  find = .false.

end subroutine nextprime

! subroutine nextprime(n)
!   INTEGER, INTENT(inout) :: n
!   INTEGER :: tmp_n
!   LOGICAL :: find = .false.
!   INTEGER :: i
!
!   if ( n == 0 ) then
!     n = 1
!     find = .true.
!   else if ( n == 1 ) then
!     n = 2
!     find = .true.
!   else if ( n == 2 ) then
!     n = 3
!     find = .true.
!   else if ( n == 3 ) then
!     n = 5
!     find = .true.
!   end if
!
! tmp_n = n
!
! do while ( .NOT. find )
!
!   i = 2
!   do while ( i < tmp_n/2 )
!       if (mod(tmp_n,i) == 0) then
!         exit
!       end if
!     i=i+1
!   end do
!
!   if ( i == tmp_n/2 .AND. n /= tmp_n ) then
!     find = .true.
!     exit
!   end if
!
!   if (find) then
!     exit
!   else
!     tmp_n = tmp_n + 1
!     !i = 2
!   end if
! end do
!
! n = tmp_n
!
! end subroutine nextprime

end program NextPrimeProg
