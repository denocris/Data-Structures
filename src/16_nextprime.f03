program NextPrimeProg
IMPLICIT NONE

integer :: num = 1031


write(*,*) 'The integer number chosen is', num
CALL nextprime(num)
write(*,*) 'its next prime number', num


CONTAINS

subroutine nextprime(n)
  INTEGER, INTENT(inout) :: n
  INTEGER :: tmp_n
  LOGICAL :: find = .false.
  INTEGER :: i


  if ( n == 1 ) then
    n = 2
  else if ( n == 2 ) then
    n = 3
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
    i = 2
  end if
end do

n = tmp_n

end subroutine nextprime

end program NextPrimeProg
