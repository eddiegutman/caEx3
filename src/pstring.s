    #311432082
    # used tests by Ron Even, Yanir, and Aviv
	.section	.rodata
invalid_input:  .string "invalid input!\n"

################################
	.text
.globl	pstrlen
    .type   pstrlen, @function
pstrlen:
    # setup
    push    %rbp        # save the old frame pointer
    movq    %rsp, %rbp  # create the new frame position

    # code
    movzbq  (%rdi), %rax  # read first byte from the given adress

    # return
    movq    %rbp, %rsp
    pop     %rbp
    ret

.globl	replaceChar
    .type   replaceChar, @function
replaceChar:
    # setup code
    pushq	%rbp	    # save the old frame pointer.
    movq	%rsp, %rbp	# create the new frame postion.

    # save caller save registers
    pushq   %rdi
    pushq   %rsi
    pushq   %rdx

    # get the string length
    call    pstrlen
    movq    %rax, %rcx  # rcx = len

    # restore registers
    popq    %rdx
    popq    %rsi
    popq    %rdi

    movq    %rdi, %r8   # save the string adresss
    movq    $1, %r9     # init i=1

    # loop condition
.replaceIf:
    cmp     %rcx, %r9       # compare i:len
    ja      .replaceDone    # if i > len finish

    # loop
.replaceLoop:
    incq    %r9    # i++
    incq    %r8 # adress++
    movzbq  (%r8), %rax # get the first byte of %r8
    cmp     %rsi, %rax  # compare first byte of string with given char
    jne     .replaceIf  # if != then go back to the condition
    movb    %dl, (%r8)  # if equal, replace the char
    jmp     .replaceIf  # go back to the condition

    # loop end
.replaceDone:
    # return
    movq    %rdi, %rax  # move the adress to the return register
    movq    %rbp, %rsp
    popq    %rbp
    ret


.globl	pstrijcpy
    .type   pstrijcpy, @function
pstrijcpy:
    # setup code
    pushq	%rbp	    # save the old frame pointer.
    movq	%rsp, %rbp	# create the new frame postion.

    # save caller save registers
    pushq   %rdi
    pushq   %rsi
    pushq   %rdx
    pushq   %rcx

    call    checkIndex  # check i and j

    # restore
    popq    %rcx
    popq    %rdx
    popq    %rsi
    popq    %rdi

    cmp     $0, %rax    # if i and j are not valid
    je     .invalidInput

    # replaces
    movq    %rdi, %rax  # copy base dstAddr to the return value
    incq    %rdi        # get to the first char
    incq    %rsi        # get to the first char
    addq    %rdx, %rdi  # set dstAddr += i
    addq    %rdx, %rsi  # set srcAddr += i

.ijcpyIf:
    cmp     %rdx, %rcx  # compare j:i
    jge     .ijcpyLoop  # if i<=j go to loop
    jmp     .ijcpyDone  # else finish

.ijcpyLoop:
    movzbq  (%rsi), %r8     # put src[i] first byto into r8
    movb    %r8b, (%rdi)    # replace dst[i] first byte with r8
    incq    %rdx            # i++
    incq    %rdi            # dstAddr++
    incq    %rsi            # srcAddr++
    jmp     .ijcpyIf

.ijcpyDone:
    movq    %rbp, %rsp
    popq    %rbp
    ret

.invalidInput:
    # print eror message
    movq    $invalid_input, %rdi
    movq    $0, %rax
    call    printf
    movq    %rbp, %rsp
    popq    %rbp
    ret

    # return 1 if i and j are valid and 0 otherswie
.type   checkIndex, @function
checkIndex:
    # setup code
    pushq	%rbp        # save the old frame pointer.
    movq	%rsp, %rbp	# create the new frame postion.

    # save caller save registers
    pushq   %rdi
    pushq   %rsi
    pushq   %rdx
    pushq   %rcx

    # get the dst string length
    call    pstrlen
    movq    %rax, %r8   # r8 = dstLen
    decq    %r8         # r8 -1, so it represents the array max index
    pushq   %r8         # save r8

    # get the src string length
    leaq    24(%rsp), %r8
    movq    (%r8), %rdi
    call    pstrlen
    movq    %rax, %r9   # r9 = srcLen
    decq    %r9         # r9 -1, so it represents the array max index

    # restore registers
    popq    %r8
    popq    %rcx
    popq    %rdx
    popq    %rsi
    popq    %rdi

    # check i
    cmp     $0, %rdx    # if i<0
    jb      .invalidIndex
    cmp     %r8, %rdx   # if i>dstLen
    ja      .invalidIndex
    cmp     %r9, %rdx   # if i>srcLen
    ja      .invalidIndex

    # check j
    cmp     $0, %rcx    # if j<0
    jb      .invalidIndex
    cmp     %r8, %rcx   # if j>dstLen
    ja      .invalidIndex
    cmp     %r9, %rcx   # if j>srcLen
    ja      .invalidIndex

    # check i and j
    cmp     %rcx, %rdx  # if i>j
    ja      .invalidIndex

    # continue if valid
    movq    $1, %rax  # move the adress to the return register
    movq    %rbp, %rsp
    popq    %rbp
    ret

.invalidIndex:
    movq    $0, %rax  # move the adress to the return register
    movq    %rbp, %rsp
    popq    %rbp
    ret


.globl	swapCase
    .type   swapCase, @function
swapCase:
    # setup code
    pushq	%rbp        # save the old frame pointer.
    movq	%rsp, %rbp	# create the new frame postion.

    pushq   %rdi        # save before function call
    call    pstrlen     # %rax holds the length
    popq    %rdi

    # code
    movq    $0, %rdx    # init i=0
    movq    %rdi, %rsi  # save the base address
    incq    %rsi        # get to the first char

.swapIf:
    cmp     %rdx, %rax  # compare len:i
    ja      .swapLoop   # if i<len go to loop
    jmp     .swapDone   # else finish

.swapLoop:
    movzbq  (%rsi), %r8  # put src[i] first byte into r8

    cmp     $65, %r8    # compare char:65
    jb      .skip       # if char < 65

    cmp     $122, %r8   # compare char:122
    ja      .skip       # if char > 122

    # 65<=char<=122

    cmp     $96, %r8    # compare char:96
    ja      .swap       # if char > 96 so 97<=char<=122

    # else 65<=char<=96
    cmp     $90, %r8    # compare char:90
    ja      .skip       # if char > 90 so 91<=char<=96

.swap:
    xor     $32, %r8        # we use xor with 32 in order to switch cases
    movb    %r8b, (%rsi)    # replace dst[i] first byte with r8

.skip:
    incq    %rdx    # i++
    incq    %rsi    # addr++
    jmp     .swapIf

.swapDone:
    movq    %rdi, %rax
    movq    %rbp, %rsp
    popq    %rbp
    ret

.globl	pstrijcmp
    .type   pstrijcmp, @function
pstrijcmp:
    # setup code
    pushq	%rbp        # save the old frame pointer.
    movq	%rsp, %rbp	# create the new frame postion.

    # save caller save registers
    pushq   %rdi
    pushq   %rsi
    pushq   %rdx
    pushq   %rcx

    call    checkIndex  # check i and j

    # restore
    popq    %rcx
    popq    %rdx
    popq    %rsi
    popq    %rdi

    cmp     $0, %rax    # if i and j are not valid
    je     .invalidInput2

    # replaces
    incq    %rdi        # get to the first char
    incq    %rsi        # get to the first char
    addq    %rdx, %rdi  # set pstr1Addr += i
    addq    %rdx, %rsi  # set pstr2Addr += i

.ijcmpIf:
    cmp     %rdx, %rcx  # compare j:i
    jge     .ijcmpLoop  # if i<=j go to loop
    jmp     .ijcmpDone  # else finish, meaning they are equal

.ijcmpLoop:
    movzbq  (%rdi), %r8  # put pstr1[i] first byto into r8
    movzbq  (%rsi), %r9  # put pstr2[i] first byto into r9

    cmp     %r9, %r8    # compare pstr1[i]:pstr2[i]
    ja      .ijcmpBig   # check if pstr1[i]>pstr2[i]
    jb      .ijcmpSmall # check if pstr1[i]<pstr2[i]

    # if they are equal we continue to check the others
    incq    %rdx    # i++
    incq    %rdi    # dstAddr++
    incq    %rsi    # srcAddr++
    jmp     .ijcmpIf

.ijcmpDone:
    movq    $0, %rax    # set return value 0
    movq    %rbp, %rsp
    popq    %rbp
    ret

.ijcmpBig:
    movq    $1, %rax    # set return value 1
    movq    %rbp, %rsp
    popq    %rbp
    ret

.ijcmpSmall:
    movq    $-1, %rax   # set return value -1
    movq    %rbp, %rsp
    popq    %rbp
    ret

.invalidInput2:
    # print eror message
    movq    $invalid_input, %rdi
    movq    $0, %rax
    call    printf
    movq    $-2, %rax
    movq    %rbp, %rsp
    popq    %rbp
    ret
