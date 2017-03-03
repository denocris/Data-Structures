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
    procedure :: find_tree_depth
    procedure :: leafs_enum
    procedure :: get_all_nodes
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
   procedure :: print_depth_and_nleafs
   procedure :: extract_sorted_array
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


type (pair) recursive function search_nodes(self, keytofind) result(ret)
  class (Node), intent(in) :: self
  integer, intent(in) :: keytofind

  if(keytofind == self % value % key) then
     ret % val = self % value % val
     ret % key = self % value % key

  else if(keytofind < self % value % key) then
     if(associated(self % left)) then
        ret = self % left % search_nodes(keytofind)
     end if
  else
     if(associated(self % right)) then
        ret = self % right % search_nodes(keytofind)
     end if
  end if

end function search_nodes

!------------------------------------------------------------
!--------------------- New Tools -----------------------
!------------------------------------------------------------

subroutine print_depth_and_nleafs(self)
  class (BinTree), intent(in) :: self
  integer :: depth
    integer :: num_leafs
  depth = 1
  call self % root_node % find_tree_depth(depth)
  print*,"The depth of the tree is ", depth
  num_leafs = 0
  call self % root_node % leafs_enum(num_leafs)
  print*,"The number of the leafs is ", num_leafs
end subroutine print_depth_and_nleafs


recursive subroutine find_tree_depth(self, depth)
  class (node), intent(in) :: self
  integer, intent(inout) :: depth

  if(self % node_depth > depth) then
     depth = self % node_depth
  end if

  if(associated(self % left)) then
     call self % left % find_tree_depth(depth)
  end if
  if(associated(self % right)) then
     call self % right % find_tree_depth(depth)
  end if

end subroutine find_tree_depth


recursive subroutine leafs_enum(self, num_leafs)
  class (Node), intent(in) :: self
  integer, intent(inout) :: num_leafs

  if(associated(self % left)) then
     call self % left % leafs_enum(num_leafs)
     if(.not. associated(self % right)) then
        num_leafs = num_leafs + 1
     end if
  end if

  if(associated(self % right)) then
     call self % right % leafs_enum(num_leafs)
     if(.not. associated(self % left)) then
        num_leafs = num_leafs + 1
     end if
  end if

end subroutine leafs_enum


subroutine extract_sorted_array(self, array)
  class (BinTree), intent(in) :: self
  type (pair), dimension(:), intent(inout) :: array
  integer :: index

  index = 1
  call self % root_node % get_all_nodes(array, index)

end subroutine extract_sorted_array

recursive subroutine get_all_nodes(self, array, index)
  class (Node), intent(in) :: self
  type(pair), dimension(:), intent(inout) :: array
  integer, intent(inout) :: index

  if(associated(self % left)) then
     call self % left % get_all_nodes(array, index)
  end if

  array(index) = self % value
  index = index + 1

  if(associated(self % right)) then
     call self % right % get_all_nodes(array, index)
  end if

end subroutine get_all_nodes


!------------------------------------------------------------
!--------------------- Rebalance -----------------------
!------------------------------------------------------------


type (BinTree) function rebalance_bintree(old_tree) result(reb_tree)
    type (BinTree), intent(in) :: old_tree
    type (pair), dimension(:), pointer :: dat
    integer :: num, mid, start, end
    logical :: fcall

    num = old_tree % get_num_nodes()
    allocate(dat(num))

    call old_tree % extract_sorted_array(dat)

    if(num > 1) then

       start = 1
       mid = (num + start)/2
       end = num + 1
       fcall = .true.

       call rebalance_add(reb_tree, dat, mid, start, end, fcall)

    else if (num == 1) then
       reb_tree = bintree_init(dat(num))
    else
       return
    end if

    deallocate(dat)
  end function rebalance_bintree


  recursive subroutine rebalance_add(new_tree, array, index, start, end, fcall)
  type (BinTree), intent(inout) :: new_tree
  integer, intent(in) :: index
  integer, intent(in) :: start
  integer, intent(in) :: end
  type (pair), dimension(:), intent(in) :: array
  logical, intent(inout) :: fcall
  integer :: midpoint_left, midpoint_right, first_end, sec_start

  if (fcall .eqv. .true.) then
     new_tree = bintree_init(array(index))
     fcall = .false.
  else
     call new_tree % add_bintree(array(index))
  end if

  if(index > start .and. index < end) then
     first_end = index
     sec_start = index+1

     midpoint_left = (index + start) / 2
     midpoint_right = (end + index + 1) / 2

     call rebalance_add(new_tree, array, midpoint_left, start, first_end, fcall)

     if(midpoint_right /= end) then
        call rebalance_add(new_tree, array, midpoint_right, sec_start, end, fcall)
     end if

  end if

end subroutine rebalance_add

end module BinaryTree
