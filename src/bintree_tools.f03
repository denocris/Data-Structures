module BinaryTree
  use list_types

  IMPLICIT NONE

  type Node
    type (pair) :: value
    type (Node), pointer :: left => NULL()
    type (Node), pointer :: right => NULL()
    integer :: node_depth

  contains
    procedure :: add_node
    procedure :: free_nodes
    procedure :: search_nodes
    !procedure :: find_depth
    !procedure :: leafs_enum
    !procedure :: get_all_nodes
  end type Node

  type BinTree
   private
   type (Node) :: root_node
   integer :: num_nodes

  contains
   procedure :: add_bintree
   procedure :: free_bintree
   procedure :: get_num_nodes
   procedure :: search_bintree
   !procedure :: print_tree_depth
   !procedure :: print_nleafs
   !procedure :: extract_sorted_array
 end type BinTree


CONTAINS

  type (BinTree) function bintree_init(n) result(new_tree)
    type (pair), intent(in) :: n

    new_tree % root_node % value = n
    new_tree % root_node % node_depth = 1
    new_tree % num_nodes = 1

  end function bintree_init


  subroutine add_bintree(self, n)
    class (BinTree), intent(inout) :: self
    type (pair), intent(in) :: n

    call self % root_node % add_node(n)

    self % num_nodes = self % num_nodes + 1

  end subroutine add_bintree

  recursive subroutine add_node(self, n)
    class (Node), intent (inout) :: self
    type (pair), intent(in) :: n
    type (Node), pointer :: new_node => NULL()

    if(self % value % key > n % key) then
      if(associated(self % left)) then
        call self % left % add_node(n)
      else
        allocate(new_node)
        new_node % value = n
        new_node % node_depth = self % node_depth + 1
        self % left => new_node
      end if
    else
     if(associated(self % right)) then
        call self % right % add_node(n)
     else
        allocate(new_node)
        new_node % value = n
        new_node % node_depth = self % node_depth + 1
        self % right => new_node
     end if
  end if
end subroutine add_node


subroutine free_bintree(self)
  class (BinTree), intent(inout) :: self

  call self % root_node % free_nodes()
  self % num_nodes = 1

end subroutine free_bintree



recursive subroutine free_nodes(self)
  class (Node), intent(inout) :: self

  if(associated(self % left)) then
     call self % left % free_nodes()
     deallocate(self % left)
  end if
  if(associated(self % right)) then
     call self % right % free_nodes()
     deallocate(self % right)
  end if

end subroutine free_nodes


integer function get_num_nodes(self) result(num)

  class (BinTree), intent(in) :: self

  num = self % num_nodes

end function get_num_nodes

type (pair) function search_bintree(self, key_to_find) result(ret)
  class (BinTree), intent(in) :: self
  integer, intent(in) :: key_to_find

  ret = self % root_node % search_nodes(key_to_find)

end function search_bintree


type (pair) recursive function search_nodes(self, n) result(ret)
  class (Node), intent(in) :: self
  integer, intent(in) :: n

  if(n == self % value % key) then
     ret % val = self % value % val
     ret % key = self % value % key

  else if(n < self % value % key) then
     if(associated(self % left)) then
        ret = self % left % search_nodes(n)
     end if
  else
     if(associated(self % right)) then
        ret = self % right % search_nodes(n)
     end if
  end if

end function search_nodes


end module BinaryTree
