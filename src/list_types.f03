MODULE list_types
IMPLICIT NONE

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

CONTAINS


  subroutine add_llist(self, item)
    class(LinkList), intent(inout), target :: self
    type (pair), intent(in) :: item
    type (LinkList), pointer :: tmp
    type (LinkList), pointer :: new_cell

    tmp => self ! ????????????

    do while (associated(tmp % next))
       tmp => tmp % next
    end do

    allocate(new_cell)

    new_cell % val = item
    tmp % next => new_cell

  end subroutine add_llist

  type(pair) function find(self, mykey) result(pair_ret)
    class (LinkList), intent(in), target :: self
    integer, intent(in) :: mykey
    type (LinkList), pointer :: tmp

    tmp => self

    do while(mykey /= tmp % val % key)
       tmp => tmp % next
    end do
    pair_ret = tmp % val
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




END MODULE list_types
