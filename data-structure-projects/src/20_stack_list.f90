PROGRAM stack_list
  use list_types

  type (StackList), pointer :: Stack1
  type (StackList), pointer :: Stack2
  integer :: stack_length

  allocate(Stack1)
  allocate(Stack2)

  stack_length = 8

  CALL Stack1 % stacklist_init()

  CALL Stack1 % stacklist_push(1)
  CALL Stack1 % stacklist_push(2)
  CALL Stack1 % stacklist_push(3)

  print*, "size 1: ", Stack1 % stacklist_length()

  CALL Stack2 % stacklist_copy(Stack1)

  CALL Stack2 % stacklist_push(5)
  CALL Stack2 % stacklist_push(6)

  !print*, "size 1: ", Stack1 % stacklist_length()
  print*, "size 2: ", Stack2 % stacklist_length()

  do while(Stack1 % stacklist_length() > 0)
      print*, 'Pop from 1:', Stack1 % stacklist_pop()
      print*, 'Length 1:', Stack1 % stacklist_length()
  end do

  DO WHILE(Stack2 % stacklist_length() > 0)
    print*, 'Pop from 2:', Stack2 % stacklist_pop()
    print*, 'Length 2:', Stack2 % stacklist_length()
  END DO

  call Stack1 % stacklist_free()
  call Stack2 % stacklist_free()
  deallocate(Stack1)
  deallocate(Stack2)


END PROGRAM stack_list
