PROGRAM stack_integer
  use list_types

  type (StackArray), pointer :: Stack1
  type (StackArray), pointer :: Stack2
  integer :: stack_length

  allocate(Stack1)
  allocate(Stack2)

  stack_length = 8

  CALL Stack1 % stackarray_init(stack_length)

  CALL Stack1 % stackarray_push(1)
  CALL Stack1 % stackarray_push(2)
  CALL Stack1 % stackarray_push(3)

  print*, "size 1: ", Stack1 % stackarray_length()

  CALL Stack2 % stackarray_copy(Stack1, stack_length)

  CALL Stack2 % stackarray_push(5)
  CALL Stack2 % stackarray_push(6)

  print*, "size 1: ", Stack1 % stackarray_length()
  print*, "size 2: ", Stack2 % stackarray_length()
  ! clean StackArrays

  do while(Stack1 % stackarray_length() > 0)
      print*, 'Pop from 1:', Stack1 % stackarray_pop()
      print*, 'Length 1:', Stack1 % stackarray_length()
  end do

  DO WHILE(Stack2 % stackarray_length() > 0)
    print*, 'Pop from 2:', Stack2 % stackarray_pop()
    print*, 'Length 2:', Stack2 % stackarray_length()
  END DO

  call Stack1 % stackarray_free()
  call Stack2 % stackarray_free()
  deallocate(Stack1)
  deallocate(Stack2)


END PROGRAM stack_integer
