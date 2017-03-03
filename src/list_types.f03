MODULE list_types
IMPLICIT NONE

!INTEGER, PARAMETER :: size = 8


  type pair
    INTEGER :: key
    REAL :: val
  end type pair

  type LinkList
     TYPE (pair) :: val
     TYPE (LinkList), POINTER :: next => NULL()
   contains
     PROCEDURE :: add_llist
     PROCEDURE :: find
     PROCEDURE :: dealloc
  end type LinkList

  type HashTable
   private
   TYPE (LinkList), ALLOCATABLE, DIMENSION(:) :: llist_bucket
   INTEGER :: num_buckets

  contains
   PROCEDURE :: hashtable_init
   PROCEDURE :: hashtable_function
   PROCEDURE :: hashtable_add_list
   PROCEDURE :: hashtable_find
   PROCEDURE :: hashtable_dealloc

 end type HashTable

 type StackArray
    private
    integer, allocatable, dimension(:) :: StackArr
    integer :: length
    integer :: index

  contains

    procedure :: stackarray_init
    procedure :: stackarray_push
    procedure :: stackarray_pop
    procedure :: stackarray_length
    procedure :: stackarray_free
    procedure :: stackarray_copy

 end type StackArray

 type StackList
    private
    type (LinkList), pointer :: StackLL
    !type (LinkList), pointer :: StackLL => NULL()
    integer :: length

  contains

    procedure :: stacklist_init
    procedure :: stacklist_push
    procedure :: stacklist_pop
    procedure :: stacklist_length
    procedure :: stacklist_free
    procedure :: stacklist_copy

 end type StackList

CONTAINS



  !-------------- Linked List -----------------------

  subroutine add_llist(self, item)
    class(LinkList), intent(inout), target :: self
    type (pair), intent(in) :: item
    type (LinkList), pointer :: tmp
    type (LinkList), pointer :: new_cell

    tmp => self ! In llist % add_lllist, tmp points to llist

    do while (associated(tmp % next))
       tmp => tmp % next
    end do

    allocate(new_cell)

    new_cell % val = item
    tmp % next => new_cell

  end subroutine add_llist

  type(pair) function find(self, mykey) result(mypair)
    class (LinkList), intent(in), target :: self
    integer, intent(in) :: mykey
    type (LinkList), pointer :: tmp

    tmp => self

    do while(mykey /= tmp % val % key)
       tmp => tmp % next
    end do
    mypair = tmp % val
  end function find

  recursive subroutine dealloc(self)
    class (LinkList), intent(inout), target :: self
    type (LinkList), pointer :: tmp
    type (LinkList), pointer :: sec_tmp

    tmp => self

    if(associated(tmp % next)) then  ! if tem % next is True
       sec_tmp => tmp % next
       call sec_tmp % dealloc()
       deallocate(tmp % next)
    else
       return
    end if
  end subroutine dealloc

! --------------- Hash Table -----------------------

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
  end if
end do

n = tmp_n

find = .false.

end subroutine nextprime


subroutine hashtable_init(self, n)
  class (HashTable), intent(inout) :: self
  integer, intent(inout) :: n
  integer :: nextpr

  CALL nextprime(n)

  nextpr = n

  self % num_buckets = nextpr

  allocate(self % llist_bucket(nextpr))
end subroutine hashtable_init

! Define hash fucntion via next prime
integer function hashtable_function(self, mykey) result(hfunc)
  class (HashTable), intent(in) :: self
  integer, intent(in) :: mykey

  hfunc = mod(mykey, self % num_buckets) + 1
end function hashtable_function

! Add new list to the hash table
subroutine hashtable_add_list(self, item)
  class (HashTable), intent(inout) :: self
  type (pair), intent(in) :: item
  integer :: index

  index = self % hashtable_function(item % key)

  call self % llist_bucket(index) % add_llist(item)
end subroutine hashtable_add_list

! Find the correct pair
type (pair) function hashtable_find(self, mykey) result(mypair)
  class (HashTable), intent(in) :: self
  integer, intent(in) :: mykey
  integer :: index

  index = self % hashtable_function(mykey)
  mypair = self % llist_bucket(index) % find(mykey)
end function hashtable_find

! Deallocate hash table
subroutine hashtable_dealloc(self)
  class (HashTable), intent(inout) :: self
  integer :: i

  do i = 1, self % num_buckets
    call self % llist_bucket(i) % dealloc()
  end do
end subroutine hashtable_dealloc

! --------------- Stack Array ------------------------

subroutine stackarray_init(self, size)
  class (StackArray), intent(inout) :: self
  integer, intent(inout) :: size
  self % length = size

  ALLOCATE(self % StackArr(self % length))
  self % index = 0

end subroutine stackarray_init


subroutine stackarray_copy(self, stack_old, size)
  class (StackArray), intent(inout) :: self
  integer, intent(inout) :: size
  type(StackArray), intent(in) :: stack_old
  !type(StackArray) :: self

  self % length = stack_old % index

  if (self % length <  size) then
    self % length = size
  end if

  ALLOCATE(self % StackArr(self % length))
  self % StackArr(:) = stack_old % StackArr(1: stack_old % index)
  self % index = stack_old % index

end subroutine stackarray_copy

integer function stackarray_length(self) result(l)
  class (StackArray), intent(in) :: self

  l = self % index - 1

end function stackarray_length


subroutine stackarray_push(self,n)
  class(StackArray), intent(inout) :: self
  integer, dimension(:), allocatable :: tmp
  integer, intent(in) :: n
  integer :: j

  if(self % index > self % length) then

     allocate(tmp(self % length + 8))

     do j=1, self % length
        tmp(j) = self % StackArr(j)
     end do

     deallocate(self % StackArr)
     self % StackArr = tmp
     self % length = self % length + 8
  endif

  self % index = self % index + 1
  self % StackArr(self % index) = n
end  subroutine stackarray_push


integer function stackarray_pop(self) result(th)
  class (StackArray), intent(inout) :: self

  self % index = self % index - 1
  th = self % StackArr(self % index)

end function stackarray_pop


subroutine stackarray_free(self)
  class (StackArray), intent(inout) :: self

  deallocate(self % StackArr)

end subroutine stackarray_free

! --------------- Stack List ------------------------

subroutine stacklist_init(self)
  class (StackList), intent(inout) :: self

  ALLOCATE(self % StackLL)
  self % length = 0

end subroutine stacklist_init


subroutine stacklist_copy(self, stack_old)
  class (StackList), intent(inout) :: self
  type(StackList), intent(in) :: stack_old
  type(LinkList), pointer :: point, new_cell

    ALLOCATE(self % StackLL)
    self % length = 0
    point => stack_old % StackLL
    new_cell => self % StackLL

  do while (ASSOCIATED(point % next))
      self % length = self % length + 1
      new_cell % val = point % val
      ALLOCATE(new_cell % next)
      new_cell => new_cell % next
      point => point % next
  end do
end subroutine stacklist_copy

integer function stacklist_length(self) result(l)
  class (StackList), intent(in) :: self

  l = self % length

end function stacklist_length

subroutine stacklist_push(self,n)
  class(StackList), intent(inout) :: self
  class(LinkList), pointer :: new_cell
  integer, intent(in) :: n


  allocate(new_cell)
  new_cell % val % key = n
  new_cell % next => self % StackLL
  self % StackLL => new_cell
  self %length = self % length + 1

end  subroutine stacklist_push

function stacklist_pop(self) RESULT(n)
  class(StackList), intent(inout) :: self
  type(LinkList), pointer :: point
  integer :: n
  n = -1

  if (self % length > 0) then
      point => self % StackLL % next
      n = self % StackLL % val % key

      deallocate(self % StackLL)

      self % StackLL => point
      self % length = self % length - 1
  end if
END FUNCTION stacklist_pop

subroutine stacklist_free(self)
  class(StackList), intent(inout) :: self
  type(LinkList), pointer :: point

  do while (self % length > 0)
      point => self % StackLL % next

      deallocate(self % StackLL)

      self % StackLL => point
      self % length = self % length - 1
  end do

  deallocate(self % StackLL)

end subroutine stacklist_free




END MODULE list_types
