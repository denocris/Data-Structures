MODULE nodes
  IMPLICIT NONE
  PRIVATE !all is private

  TYPE node
      INTEGER :: val
      TYPE(node),POINTER :: next
    CONTAINS
      PROCEDURE :: get
      PROCEDURE :: set
      PROCEDURE :: append
  END TYPE node

  INTERFACE node
      MODULE PROCEDURE node_default
      MODULE PROCEDURE node_copy
      MODULE PROCEDURE node_val
  END INTERFACE node

  PUBLIC :: node  !common practice

CONTAINS
  TYPE(node) FUNCTION node_default() !costructors
    node_default%next => NULL()
    node_default%val = -1
  END FUNCTION node_default

  TYPE(node) FUNCTION node_copy(n) !copy another node
    TYPE(node) :: n
    node_copy%next => n%next
    node_copy%val = n%val
  END FUNCTION node_copy

  TYPE(node) FUNCTION node_val(i) !inizialised by an output
    INTEGER,INTENT(in) :: i
    node_val%next => NULL()
    node_val%val = i
  END FUNCTION node_val

  INTEGER FUNCTION get(self)
    CLASS(node) :: self
    get = self%val
  END FUNCTION get

  SUBROUTINE set(self,i)
    CLASS(node) :: self
    INTEGER,INTENT(in) :: i
    self%val = i
  END SUBROUTINE set

  SUBROUTINE append(self,n) ! go to the null
    CLASS(node),TARGET :: self
    TYPE(node),POINTER :: n,ptr
    ptr => self
    DO WHILE (ASSOCIATED(ptr%next))
        ptr => ptr%next
    END DO
    ptr%next => n !pay attention that n poit to null
  END SUBROUTINE append

END MODULE nodes


PROGRAM test_node
  !USE nodes
  USE list_types
  IMPLICIT NONE
  TYPE(pair) :: p1, p2, p3
  TYPE (LinkList), pointer :: llist
  TYPE (LinkList), pointer :: tmp
  TYPE (LinkList), pointer :: tmp2
  INTEGER :: i

  ALLOCATE(llist)

  p1 % key = 1
  p1 % val = 0.1
  p2 % key = 2
  p2 % val = 0.2
  p3 % key = 3
  p3 % val = 0.3

  call llist % add_llist(p1)
  call llist % add_llist(p2)
  call llist % add_llist(p3)


  ! Eliminate the first block since no value inside
    tmp2 => llist
    llist => llist % next
    deallocate(tmp2)
    nullify(tmp2)

  tmp => llist
  !PRINT*,'val=', head%get(), nn%get(), n%get()

  i = 1
  DO WHILE (ASSOCIATED(tmp)) !while pointer isn't null continue
      PRINT*,i,' -> ',tmp % val % key
      tmp => tmp % next
      i = i+1
  END DO

  call dealloc(llist)
  PRINT*,'done'
END PROGRAM test_node
