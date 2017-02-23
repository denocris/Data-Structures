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
  USE nodes
  IMPLICIT NONE
  TYPE(node),POINTER :: head,nn,ptr
  TYPE(node), TARGET :: n !You need taget for use the pointer in fortran
  INTEGER :: i

  ALLOCATE(head,nn)
  head = node(1) !give the value 1 node_val
  nn = node() !default
  n = node() !default
  ptr => n
  CALL n%set(20) !20 is the value of n%val
  CALL head%append(nn) !add nn in head
  CALL head%append(ptr) !add ptr to head->nn->n(NULL)

  PRINT*,'val=', head%get(), nn%get(), n%get()

  ptr => head
  i = 1
  DO WHILE (ASSOCIATED(ptr)) !while pointer isn't null continue
      PRINT*,i,' -> ',ptr%get()
      ptr => ptr%next
      i = i+1
  END DO

  DEALLOCATE(head,nn)
  PRINT*,'done'
END PROGRAM test_node
