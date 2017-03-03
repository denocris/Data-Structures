

PROGRAM array_lookup
  USE list_types
  IMPLICIT NONE

  INTEGER :: num, i, j
  REAL :: chk, rv, time1, time2
  INTEGER, ALLOCATABLE, DIMENSION(:) :: idx
  TYPE (pair),ALLOCATABLE,DIMENSION(:) :: dat
  TYPE (pair) :: p
  INTEGER, PARAMETER :: nlook = 5000
  TYPE (HashTable), pointer :: HTable
  !TYPE (LinkList), pointer :: tmp
  INTEGER :: n_init = 150

  READ(5,*) num
  ALLOCATE(dat(num))
  READ(5,*) (dat(i),i=1,num)
  READ(5,*) chk

  !fill linked list or hash table with items from dat() here

  allocate(HTable)
  CALL HTable % hashtable_init(n_init)
  do i=1,num
    call HTable % hashtable_add_list(dat(i))
  end do

  ! fill idx array with randomly selected keys
  CALL RANDOM_SEED()

  ALLOCATE(idx(nlook))
  DO i=1,nlook
      CALL RANDOM_NUMBER(rv)
      j = INT(rv*num)+1
      idx(i) = dat(j)%key
  END DO

  CALL CPU_TIME(time1)
    DO i=1,nlook
        DO j=1,num
            IF (dat(j)%key == idx(i)) THEN
                p = dat(j)
                EXIT
            END IF
        END DO
    END DO
    CALL CPU_TIME(time2)
    WRITE(*,FMT=666) nlook, 'array value lookups', (time2-time1)*1000.0
    if (p%key > 1.7) call cpu_time(p%val)

  CALL CPU_TIME(time1)
  DO i=1,nlook
      !do linked list or hash table lookups here
      p = HTable % hashtable_find(idx(i))
  END DO
  CALL CPU_TIME(time2)
  WRITE(*,FMT=666) nlook, 'hash table lookups', (time2-time1)*1000.0

  ! free all allocated data
  DEALLOCATE(dat,idx)
  CALL HTable % hashtable_dealloc()
  CALL hashtable_dealloc(HTable)
  nullify(HTable)

666 FORMAT (' Performing',I8,1X,A20,1X,'took:',F12.6,' ms')
END PROGRAM array_lookup
