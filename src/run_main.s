	#311432082
	# used tests by Ron Even, Yanir, and Aviv
	.section	.rodata
scan_string:  .string " %s"
scan_num:   .string "%hhu"
scan_int:   .string "%d"

################################
	.text
.globl	run_main
	.type	run_main, @function
run_main:
    # setup code
	pushq	%rbp	# save the old frame pointer.
	movq	%rsp, %rbp	# create the new frame postion.

    subq    $256, %rsp  # allocate 256 bytes for the first pstring

    # scan n1
    movq    $scan_num, %rdi
    movq    %rsp, %rsi
    movq    $0, %rax
    call    scanf

    # scan first string
    movq    $scan_string, %rdi
    leaq    1(%rsp), %rsi
    movq    $0, %rax
    call    scanf

    subq    $256, %rsp  # allocate 256 bytes for the second pstring

    # scan n2
    movq    $scan_num, %rdi
    movq    %rsp, %rsi
    movq    $0, %rax
    call    scanf

    # scan second string
    movq    $scan_string, %rdi
    leaq    1(%rsp), %rsi
    movq    $0, %rax
    call    scanf

    subq    $16, %rsp  # allocate 16 bytes for the menu option and alignment

    # scan option
    movq    $scan_int, %rdi
    movq    %rsp, %rsi
    movq    $0, %rax
    call    scanf

    # set argument for run_func
    movl    (%rsp), %edi    # set menu option as first argument
    leaq    272(%rsp), %rsi # set first pstring as second argument
    leaq    16(%rsp), %rdx  # set second pstring as third argument

    call    run_func

    # deallocation
    addq    $16, %rsp   # deallocate menu option
    addq    $256, %rsp  # deallocate second pstring
    addq    $256, %rsp  # deallocate first pstring

    # return
    movq    %rbp, %rsp
    pop     %rbp
    ret
