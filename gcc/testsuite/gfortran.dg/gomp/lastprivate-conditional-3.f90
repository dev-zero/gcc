subroutine foo
  integer i, j, k
  !$omp parallel
    !$omp do lastprivate (conditional: i)	! { dg-warning "conditional 'lastprivate' on loop iterator 'i' ignored" }
    do i = 1, 32
    end do
    !$omp do collapse (3) lastprivate (conditional: i)	! { dg-warning "conditional 'lastprivate' on loop iterator 'i' ignored" }
    do i = 1, 32
      do j = 1, 32
        do k = 1, 32
        end do
      end do
    end do
    !$omp do collapse (3) lastprivate (conditional: j)	! { dg-warning "conditional 'lastprivate' on loop iterator 'j' ignored" }
    do i = 1, 32
      do j = 1, 32
        do k = 1, 32
        end do
      end do
    end do
    !$omp do collapse (3) lastprivate (conditional: k)	! { dg-warning "conditional 'lastprivate' on loop iterator 'k' ignored" }
    do i = 1, 32
      do j = 1, 32
        do k = 1, 32
        end do
      end do
    end do
  !$omp end parallel

  ! Error in eqiv. C code: "conditional 'lastprivate' on loop iterator 'i' ignored"
  !$omp parallel do lastprivate (conditional: i)
  do i = 1, 32
  end do
  !$omp end parallel do

  ! Error in eqiv. C code: "conditional 'lastprivate' on loop iterator 'i' ignored"
  !$omp parallel do collapse (3) lastprivate (conditional: i)
  do i = 1, 32
    do j = 1, 32
      do k = 1, 32
      end do
    end do
  end do
  !$omp end parallel do

  ! Error in eqiv. C code: "conditional 'lastprivate' on loop iterator 'j' ignored"
  !$omp parallel do collapse (3) lastprivate (conditional: j)
  do i = 1, 32
    do j = 1, 32
      do k = 1, 32
      end do
    end do
  end do
  !$omp end parallel do

  ! Error in eqiv. C code: "conditional 'lastprivate' on loop iterator 'k' ignored"
  !$omp parallel do collapse (3) lastprivate (conditional: k)
  do i = 1, 32
    do j = 1, 32
      do k = 1, 32
      end do
    end do
  end do
  !$omp end parallel do
end subroutine
