	#311432082
	# used tests by Ron Even, Yanir, and Aviv
	.section	.rodata
	.align 8
.L1:
	.quad	.L50	# i=0 : Case 50
	.quad	.L2	    # i=1 : Default case
	.quad	.L52	# i=2 : Case 52
	.quad	.L53	# i=3 : Case 53
	.quad	.L54	# i=4 : Case 54
	.quad	.L55	# i=5 : Case 55
	.quad	.L2	    # i=6 : Default case
	.quad	.L2	    # i=7 : Default case
	.quad	.L2 	# i=8 : Default case
	.quad	.L2	    # i=9 : Default case
	.quad	.L50	# i=10: Case 60

format_c50: .string "first pstring length: %d, second pstring length: %d\n"
format_c52: .string "old char: %c, new char: %c, first string: %s, second string: %s\n"
format_c53: .string "length: %d, string: %s\n"
format_c55: .string "compare result: %d\n"
invalid_option: .string "invalid option!\n"

scan_char:  .string " %c"
scan_num:   .string "%hhu"

################################
	.text
.globl	run_func
	.type	run_func, @function
run_func:
	# setup code
	pushq	%rbp        # save the old frame pointer.
	movq	%rsp, %rbp	# create the new frame postion.

    # code
	leal	-50(%edi), %edi	# compute i = menuOption-50
	cmpl	$10, %edi       # compare menuOption:10
	ja	.L2                 # if > go to deault case
	jmp	*.L1(,%edi,8)       # go to JT[i]

# case 50 or 60
.L50:
    pushq   %rdx    # save second pstring adress

    # set function arguments
    movq    %rsi, %rdi  # move the first string address to the first argument

    call    pstrlen # get the length of first pstring
    popq    %rdi    # move the second string adress to the second argument
    pushq   %rax    # save the first string length

    call    pstrlen # get the length of the second pstring

    # set function arguments
    movq    $format_c50, %rdi   # set the print format as first argument
    popq    %rsi                # set first pstring length as second argument
    movq    %rax, %rdx          # set second pstring length as third argument

    movq    $0, %rax
    call    printf
    jmp     .L3


# case 52
.L52:
    # save caller save arguments
    pushq   %r12    # save first string adress
    pushq   %r13    #  save second pstring adress

    movq    %rsi, %r12
    movq    %rdx, %r13

    # scan old char
    movq    $scan_char, %rdi
    subq    $16, %rsp    # allocate space for old char and align stack to 16
    movq    %rsp, %rsi
    movq    $0, %rax
    call    scanf

    # scan new char
    movq    $scan_char, %rdi
    subq    $16, %rsp    # allocate space for new char and align stack to 16
    movq    %rsp, %rsi
    movq    $0, %rax
    call    scanf

    # set arguments for first call of replaceChar
    leaq    (%rsp), %r8
    movzbq    (%r8), %rdx   # move new char to third argument
    leaq    16(%rsp), %r8
    movzbq    (%r8), %rsi   # move old char to second argument
    movq    %r13, %rdi      # move second psrtring address to first argument

    call    replaceChar

    movq    %rax, %r14

    # set arguments for second call of replaceChar
    leaq    (%rsp), %r8
    movzbq    (%r8), %rdx   # move new char to third argument
    leaq    16(%rsp), %r8
    movzbq    (%r8), %rsi   # move old char to second argument
    movq    %r12, %rdi      # move first pstring address to first argument

    call    replaceChar

    # set function arguments
    movq    $format_c52, %rdi   # set the print format as first argument
    popq    %rdx                # set new char adress as third argument
    popq    %r8                 # pop empty stack alignment
    popq    %rsi                # set old char as second argument
    popq    %r8                 # pop empty stack alignment

    movq    %rax, %rcx  # set first string address as fourth argument
    incq    %rcx        # go to the byte of the string
    movq    %r14, %r8   # set second string address as fifth argument
    incq    %r8         # go to the byte of the string

    movq    $0, %rax
    call    printf
    jmp     .L3

# case 53
.L53:
	# save caller saved registers
    pushq   %rdx    #  save src pstring adress
    pushq   %rsi    # save dst string adress

    # scan i
    movq    $scan_num, %rdi
    subq    $16, %rsp    # allocate space for i and align stack to 16
    movq    %rsp, %rsi
    movq    $0, %rax
    call    scanf

    # scan j
    movq    $scan_num, %rdi
    subq    $16, %rsp    # allocate space for j and align stack to 16
    movq    %rsp, %rsi
    movq    $0, %rax
    call    scanf

    # set arguments for the call of pstrijcpy
    popq    %r8
    movzbq  %r8b, %rcx      # move j to fourth argument
    popq    %r8             # pop the empty alignment addition
    popq    %r8
    movzbq  %r8b, %rdx      # move i to third argument
    popq    %r8             # pop the empty alignment addition
    leaq    8(%rsp), %r8
    movq    (%r8), %rsi     # move src psrtring address to second argument
    movq    (%rsp), %rdi    # move the dst pstring address to the first argument

    call    pstrijcpy

    # set arguments for first print
    movq    (%rsp), %rdi
    call    pstrlen
    movq    %rax, %rsi          # set len as second argument

    movq    $format_c53, %rdi   # set print format as first argument
    movq    (%rsp), %rdx        # set dst pstring address as third argument
    incq    %rdx                # go to the first byte of the string
    movq    $0, %rax
    call    printf

    # set arguments for second print
    movq    8(%rsp), %rdi
    call    pstrlen
    movq    %rax, %rsi  # set len as second argument

    movq    $format_c53, %rdi   # set print format as first argument
    movq    8(%rsp), %rdx       # set src pstring address as third argument
    incq    %rdx                # go to the first byte of the string
    movq    $0, %rax
    call    printf

    popq    %rdi
    popq    %rdi

    jmp     .L3

# case 54
.L54:
    # save calee saved registers
    pushq   %r12
    pushq   %r13

    # save caller save registers
    movq    %rdx, %r12  # save src pstring adress
    movq    %rsi, %r13  # save dst string adress

    # set arguments for first call of swapCase
    movq    %r13, %rdi  # move the dst pstring address to the first argument

    call    swapCase

    # set arguments for first print
    movq    %r13, %rdi
    call    pstrlen
    movq    %rax, %rsi  # set len as second argument

    movq    $format_c53, %rdi   # set print format as first argument
    movq    %r13, %rdx          # set dst pstring address as third argument
    incq    %rdx                # go to the first byte of the string
    movq    $0, %rax
    call    printf

    # set arguments for second call of swapCase
    movq    %r12, %rdi  # move the dst pstring address to the first argument

    call    swapCase

    # set arguments for second print
    movq    %r12, %rdi
    call    pstrlen
    movq    %rax, %rsi  # set len as second argument

    movq    $format_c53, %rdi   # set print format as first argument
    movq    %r12, %rdx          # set src pstring address as third argument
    incq    %rdx                # go to the first byte of the string
    movq    $0, %rax
    call    printf

    # restore calee saved register
    popq    %r13
    popq    %r12

    jmp     .L3

# case 55
.L55:
	# save caller saved registers
	pushq   %rsi    # save dst string adress
    pushq   %rdx    #  save src pstring adress

    # scan i
    movq    $scan_num, %rdi
    subq    $16, %rsp    # allocate space for i and align stack to 16
    leaq    (%rsp), %rsi
    movq    $0, %rax
    call    scanf

    # scan j
    movq    $scan_num, %rdi
    subq    $16, %rsp    # allocate space for i and align stack to 16
    leaq    (%rsp), %rsi
    movq    $0, %rax
    call    scanf

    # set arguments for the call of pstrcmpij
    popq    %r8
    movzbq  %r8b, %rcx  # move j to fourth argument
    popq    %r8         # pop the empty alignment addition
    popq    %r8
    movzbq  %r8b, %rdx  # move i to third argument
    popq    %r8         # pop the empty alignment addition
    popq    %rsi        # move src psrtring address to second argument
    popq    %rdi        # move the dst pstring address to the first argument

    call    pstrijcmp

    # set arguments for the print
    movq    $format_c55, %rdi   # set print format as first argument
    movq    %rax, %rsi
    movq    $0, %rax
    call    printf

    jmp     .L3

# default case
.L2:
	movq    $invalid_option, %rdi   # set print format as first argument
    movq    $0, %rax
    call    printf

.L3:
    # return
    movq    %rbp, %rsp
    pop     %rbp
    ret
